module Internal.Model.Attribute exposing (Attribute(..))

import PdfMake.Page exposing (PageBreak)
import Internal.Model.Style as Style


type Attribute
    = AbsolutePosition Position
    | Margins Margin
    | PageBreak PageBreak
    | Style (List Style.Attribute)


type alias Position =
    { x : Float
    , y : Float
    }


type alias Margin =
    { left : Float
    , right : Float
    , top : Float
    , bottom : Float
    }
