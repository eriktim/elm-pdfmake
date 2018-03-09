module Internal.Encode.Style exposing (value, values)

import Internal.Encode.Color as Color
import Internal.Model.Style exposing (Attribute(..))
import Internal.Object exposing (Value, bool, float, int, object, string)
import PdfMake.Page exposing (TextAlignment(..))


value : List Attribute -> Value
value =
    object << values


values : List Attribute -> List ( String, Value )
values =
    List.map attrValue



-- INTERNAL


attrValue : Attribute -> ( String, Value )
attrValue attr =
    case attr of
        Bold ->
            ( "bold", bool True )

        Color color ->
            ( "color", Color.value color )

        Font font ->
            ( "font", string font )

        FontSize size ->
            ( "fontSize", int size )

        Italic ->
            ( "italics", bool True )

        LineHeight height ->
            ( "lineHeight", float height )

        Alignment alignment ->
            ( "alignment", textAlignment alignment )



-- HELPERS


textAlignment : TextAlignment -> Value
textAlignment alignment =
    string <|
        case alignment of
            Left ->
                "left"

            Right ->
                "right"

            Centered ->
                "centered"

            Justified ->
                "justified"
