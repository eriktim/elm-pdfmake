module Internal.Model.Table
    exposing
        ( Layout(..)
        , Width(..)
        )

import Internal.Model.Function exposing (LineColor, LineWidth, Padding)


type Width
    = Auto
    | Fill
    | Inch Float


type Layout
    = DefaultBorder Bool
    | LineWidthHorizontal LineWidth
    | LineWidthVertical LineWidth
    | LineColorHorizontal LineColor
    | LineColorVertical LineColor
    | PaddingBottom Padding
    | PaddingLeft Padding
    | PaddingRight Padding
    | PaddingTop Padding
