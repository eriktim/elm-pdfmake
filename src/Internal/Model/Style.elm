module Internal.Model.Style exposing (Attribute(..))

import Color


type Attribute
    = Bold
    | Color Color.Color
    | Font String
    | FontSize Int
    | Italic
    | LineHeight Float
