module Internal.Encode.Table exposing (attrValue, value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Model.Node exposing (Node, TableAttribute(..))
import Internal.Model.Table exposing (Width(..))
import Internal.Object exposing (Value, bool, float, int, list, string)


attrValue : TableAttribute -> ( String, Value )
attrValue attr =
    case attr of
        Alignment value ->
            ( "alignment", Page.textAlignment value )

        Border ( left, top, right, bottom ) ->
            ( "border", list <| List.map bool [ left, top, right, bottom ] )

        ColSpan value ->
            ( "colSpan", int value )

        FillColor color ->
            ( "fillColor", Color.value color )

        RowSpan value ->
            ( "rowSpan", int value )


value : Width -> Value
value width =
    case width of
        Auto ->
            string "auto"

        Fill ->
            string "*"

        Inch value ->
            float (dpi value)
