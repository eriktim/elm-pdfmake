module Internal.Model.Style exposing (Attribute(..))

import Color
import PdfMake.Page exposing (TextAlignment)


type Attribute
    = Bold
    | Color Color.Color
    | Font String
    | FontSize Int
    | Italic
    | LineHeight Float
    | Alignment TextAlignment
