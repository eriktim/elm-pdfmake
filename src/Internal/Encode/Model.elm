module Internal.Encode.Model exposing (value)

import Internal.Encode.Node as Node
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer(..), Header(..))
import Internal.Object exposing (Value, list, literal, object, stringify)
import PdfMake.Page exposing (PageOrientation(..))


value : (f -> String) -> Model f -> Value
value fn model =
    object
        [ ( "pageSize", Page.pageSize model.pageSize )
        , ( "pageOrientation", Page.pageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
        , ( "pageMargins", Page.pageMargins <| Maybe.withDefault { left = 1, top = 1, right = 1, bottom = 1 } model.pageMargins )
        , ( "content", list <| List.map (Node.value fn) model.content )
        , ( "defaultStyle", Style.value <| Maybe.withDefault [] model.defaultStyle )
        , ( "header", Maybe.withDefault (literal "undefined") <| Maybe.map (header fn) model.header )
        , ( "footer", Maybe.withDefault (literal "undefined") <| Maybe.map (footer fn) model.footer )
        ]



-- INTERNAL


header : (f -> String) -> Header f -> Value
header fn header_ =
    case header_ of
        Header function ->
            Node.functionValue fn function


footer : (f -> String) -> Footer f -> Value
footer fn footer_ =
    case footer_ of
        Footer function ->
            Node.functionValue fn function
