module Internal.Encode.Table exposing (attrValue, layoutValue, value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Model.Function exposing (LineColor(..), LineWidth(..), Padding(..))
import Internal.Model.Node exposing (Node, TableAttribute(..))
import Internal.Model.Table exposing (Layout(..), Width(..))
import Internal.Object exposing (Value, bool, float, int, list, literal, string, stringify)


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


layoutValue : Layout -> ( String, Value )
layoutValue layout =
    case layout of
        DefaultBorder value ->
            ( "defaultBorder", bool value )

        LineWidthHorizontal width ->
            case width of
                LineWidth function ->
                    ( "hLineWidth", fn function.body )

        LineWidthVertical width ->
            case width of
                LineWidth function ->
                    ( "vLineWidth", fn function.body )

        LineColorHorizontal color ->
            case color of
                LineColor function ->
                    ( "hLineColor", fn function.body )

        LineColorVertical color ->
            case color of
                LineColor function ->
                    ( "vLineColor", fn function.body )

        PaddingBottom padding ->
            case padding of
                Padding function ->
                    ( "paddingBottom", fn function.body )

        PaddingLeft padding ->
            case padding of
                Padding function ->
                    ( "paddingLeft", fn function.body )

        PaddingRight padding ->
            case padding of
                Padding function ->
                    ( "paddingRight", fn function.body )

        PaddingTop padding ->
            case padding of
                Padding function ->
                    ( "paddingTop", fn function.body )


value : Width -> Value
value width =
    case width of
        Auto ->
            string "auto"

        Fill ->
            string "*"

        Inch value ->
            float (dpi value)



-- INTERNAL


fn : String -> Value
fn body =
    literal <| "(i, node) => {" ++ body ++ "}"
