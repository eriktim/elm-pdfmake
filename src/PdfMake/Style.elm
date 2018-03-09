module PdfMake.Style
    exposing
        ( Attribute
        , alignment
        , bold
        , color
        , font
        , fontSize
        , italic
        , lineHeight
        )

import Color
import Internal.Model.Style as Style exposing (Attribute(..))
import PdfMake.Page exposing (TextAlignment)


type alias Attribute =
    Style.Attribute


alignment : TextAlignment -> Attribute
alignment =
    Alignment


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
