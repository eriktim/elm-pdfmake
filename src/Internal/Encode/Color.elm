module Internal.Encode.Color exposing (value)

import Char
import Color
import Internal.Object exposing (Value, string)


value : Color.Color -> Value
value color =
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
    string <| "#" ++ r ++ g ++ b



-- INTERNAL


componentToHex : Int -> String
componentToHex val =
    let
        high =
            clamp 0 16 <| val // 16

        low =
            val - (16 * high)
    in
    toHex high ++ toHex low


toHex : Int -> String
toHex val =
    String.fromChar <|
        if val < 10 then
            Char.fromCode (48 + val)
        else
            Char.fromCode (87 + val)
