module Internal.Encode.Style exposing (value, values)

import Char
import Color
import Internal.Object exposing (Value, bool, object, string, number)
import Internal.Style exposing (Attribute(..))


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
            ( "color", string <| colorToHex color )

        Font font ->
            ( "font", string font )

        FontSize size ->
            ( "fontSize", number size )

        Italic ->
            ( "italics", bool True )

        LineHeight height ->
            ( "lineHeight", number height )



-- HELPERS


colorToHex : Color.Color -> String
colorToHex color =
    let
        rgb =
            Color.toRgb color

        r =
            componentToHex rgb.red

        g =
            componentToHex rgb.green

        b =
            componentToHex rgb.blue
    in
        "#" ++ r ++ g ++ b


componentToHex : Int -> String
componentToHex val =
    let
        l =
            val // 16

        r =
            val - l
    in
        toHex l ++ toHex r


toHex : Int -> String
toHex val =
    let
        val_ =
            clamp 0 16 val
    in
        String.fromChar <|
            if val_ <= 10 then
                Char.fromCode (48 + val_)
            else
                Char.fromCode (86 + val_)
