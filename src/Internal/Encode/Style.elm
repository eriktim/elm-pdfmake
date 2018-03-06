module Internal.Encode.Style exposing (value, values)

import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Model.Style exposing (Attribute(..))
import Internal.Object exposing (Value, bool, float, int, object, string)


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
            ( "alignment", Page.textAlignment alignment )
