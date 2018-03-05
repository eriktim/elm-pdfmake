module PdfMake.Style
    exposing
        ( Attribute
        , bold
        , color
        , font
        , fontSize
        , italic
        , lineHeight
        )

import Color
import Internal.Style as Style exposing (Attribute(..))


type alias Attribute =
    Style.Attribute


bold : Attribute
bold =
    Bold


color : Color.Color -> Attribute
color =
    Color


font : String -> Attribute
font =
    Font


fontSize : Int -> Attribute
fontSize =
    FontSize


italic : Attribute
italic =
    Italic


lineHeight : Float -> Attribute
lineHeight =
    LineHeight
