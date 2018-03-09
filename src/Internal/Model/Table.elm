module Internal.Model.Table
    exposing
        ( Layout(..)
        , Width(..)
        )

import Internal.Model.Function exposing (Function, LineColor, LineWidth, Padding)


type Width
    = Auto
    | Fill
    | Inch Float


type Layout
    = DefaultBorder Bool
    | FillColor Function
    | LineWidthHorizontal LineWidth
    | LineWidthVertical LineWidth
    | LineColorHorizontal LineColor
    | LineColorVertical LineColor
    | PaddingBottom Padding
    | PaddingLeft Padding
    | PaddingRight Padding
    | PaddingTop Padding
