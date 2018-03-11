module Internal.Model exposing (Model)

import Dict
import Internal.Model.Node exposing (Footer, Header, Node)
import Internal.Model.Style exposing (Attribute)
import PdfMake.Page exposing (PageOrientation, PageSize)


type alias Model f =
    { pageSize : PageSize
    , content : List (Node f)
    , pageOrientation : Maybe PageOrientation
    , pageMargins : Maybe ( Float, Float, Float, Float )
    , defaultStyle : Maybe (List Attribute)
    , header : Maybe (Header f)
    , footer : Maybe (Footer f)
    }
