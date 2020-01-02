module Internal.Encode.Model exposing (value)

import Internal.Encode.Node as Node
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer(..), Header(..))
import Internal.Object exposing (Value, list, literal, object, stringify)
import PdfMake.Page exposing (PageOrientation(..))


value : Model -> Value
value model =
    object
        [ ( "pageSize", Page.pageSize model.pageSize )
        , ( "pageOrientation", Page.pageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
        , ( "pageMargins", Page.pageMargins <| Maybe.withDefault { left = 1, top = 1, right = 1, bottom = 1 } model.pageMargins )
        , ( "content", list <| List.map Node.value model.content )
        , ( "defaultStyle", Style.value <| Maybe.withDefault [] model.defaultStyle )
        , ( "header", Maybe.withDefault (literal "undefined") <| Maybe.map header model.header )
        , ( "footer", Maybe.withDefault (literal "undefined") <| Maybe.map footer model.footer )
        ]



-- INTERNAL


header : Header -> Value
header header_ =
    case header_ of
        Header node ->
            Node.value node


footer : Footer -> Value
footer footer_ =
    case footer_ of
        Footer node ->
            Node.value node
