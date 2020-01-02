module Internal.Model.Style exposing (Attribute(..), Style)

import Color
import PdfMake.Page exposing (TextAlignment)


type alias Style =
    List Attribute


type Attribute
    = Bold
    | Color Color.Color
    | Font String
    | FontSize Int
    | Italic
    | LineHeight Float
    | Alignment TextAlignment
