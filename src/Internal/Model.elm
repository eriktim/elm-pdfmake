module Internal.Model exposing (Model)

import Dict
import Internal.Model.Node as Node
import Internal.Model.Style as Style
import PdfMake.Page as Page


type alias Model =
    { pageSize : Page.PageSize
    , content : List Node.Node
    , pageOrientation : Maybe Page.PageOrientation
    , pageMargins : Maybe { left : Float, top : Float, right : Float, bottom : Float }
    , defaultStyle : Maybe Style.Style
    , header : Maybe Node.Header
    , footer : Maybe Node.Footer
    , styles : Dict.Dict String Style.Style
    }
