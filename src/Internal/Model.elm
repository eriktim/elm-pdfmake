module Internal.Model exposing (Model)

import Dict
import Internal.Model.Node as Node
import Internal.Model.Style as Style
import PdfMake.Page as Page


type alias Model layout image =
    -- TODO: builder
    { pageSize : Page.PageSize
    , content : List (Node.Node layout image)
    , pageOrientation : Maybe Page.PageOrientation
    , pageMargins : Maybe { left : Float, top : Float, right : Float, bottom : Float }
    , defaultStyle : Maybe Style.Style
    , header : Maybe (Node.Header layout image)
    , footer : Maybe (Node.Footer layout image)
    , styles : Dict.Dict String Style.Style
    }
