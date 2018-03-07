module PdfMake.Attribute
    exposing
        ( Attribute
        , absolutePosition
        , margins
        , pageBreak
        )

import PdfMake.Page exposing (PageBreak)
import Internal.Model.Attribute as Attribute exposing (Attribute(..))


type alias Attribute =
    Attribute.Attribute


absolutePosition : Float -> Float -> Attribute
absolutePosition x y =
    AbsolutePosition
        { x = x
        , y = y
        }


margins : Float -> Float -> Float -> Float -> Attribute
margins left top right bottom =
    Margins
        { left = left
        , top = top
        , right = right
        , bottom = bottom
        }


pageBreak : PageBreak -> Attribute
pageBreak =
    PageBreak
