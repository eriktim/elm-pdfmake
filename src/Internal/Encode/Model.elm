module Internal.Encode.Model exposing (value)

import Internal.Encode.Node as Node
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer(..), Header(..))
import Internal.Object exposing (Value, list, literal, object, stringify)
import PdfMake.Page exposing (PageOrientation(..))


value : (f -> String) -> (img -> (String, String)) -> Model f img -> Value
value fn img model =
    object
        [ ( "pageSize", Page.pageSize model.pageSize )
        , ( "pageOrientation", Page.pageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
        , ( "pageMargins", Page.pageMargins <| Maybe.withDefault ( 1, 1, 1, 1 ) model.pageMargins )
        , ( "content", list <| List.map (Node.value fn img) model.content )
        , ( "defaultStyle", Style.value <| Maybe.withDefault [] model.defaultStyle )
        , ( "header", Maybe.withDefault (literal "undefined") <| Maybe.map (header fn img) model.header )
        , ( "footer", Maybe.withDefault (literal "undefined") <| Maybe.map (footer fn img) model.footer )
        ]



-- INTERNAL


header : (f -> String) -> (img -> (String, String)) -> Header f img -> Value
header fn img header_ =
    case header_ of
        Header function ->
            Node.functionValue fn img function


footer : (f -> String) -> (img -> (String, String)) -> Footer f img -> Value
footer fn img footer_ =
    case footer_ of
        Footer function ->
            Node.functionValue fn img function
