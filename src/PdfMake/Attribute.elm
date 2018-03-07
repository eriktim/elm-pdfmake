module PdfMake.Attribute
    exposing
        ( Attribute
        , absolutePosition
        , margins
        , pageBreak
        )

import Internal.Model.Attribute as Attribute exposing (Attribute(..))
import PdfMake.Page exposing (PageBreak)


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
