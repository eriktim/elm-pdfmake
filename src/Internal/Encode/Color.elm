module Internal.Encode.Color exposing (encode)

import Char
import Color
import Json.Encode as Encode


encode : Color.Color -> Encode.Value
encode color =
    let
        rgb =
            Color.toRgba color

        int =
            floor << (*) 255

        r =
            componentToHex <| int rgb.red

        g =
            componentToHex <| int rgb.green

        b =
            componentToHex <| int rgb.blue
    in
    Encode.string <| "#" ++ r ++ g ++ b



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
