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
    [ ( "pageSize", Page.pageSize model.pageSize )
    , ( "pageOrientation", Page.pageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
    , ( "content", list <| List.map (Node.value fn) model.content )
    ]
        ++ optional "pageMargins" Page.pageMargins model.pageMargins
        ++ optional "defaultStyle" Style.value model.defaultStyle
        ++ optional "header" (header fn) model.header
        ++ optional "footer" (footer fn) model.footer
        |> object



-- INTERNAL


optional : String -> (a -> Value) -> Maybe a -> List ( String, Value )
optional key f value =
    case value of
        Just value_ ->
            [ ( key, f value_ ) ]

        Nothing ->
            []


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
