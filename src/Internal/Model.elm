module Internal.Model exposing (Model)

import Dict
import Internal.Model.Function exposing (HeaderFooter)
import Internal.Model.Node exposing (Node)
import Internal.Model.Style exposing (Attribute)
import PdfMake.Page exposing (PageOrientation, PageSize)


type alias Model =
    { pageSize : PageSize
    , content : List Node
    , pageOrientation : Maybe PageOrientation
    , pageMargins : Maybe ( Float, Float, Float, Float )
    , defaultStyle : Maybe (List Attribute)
    , header : Maybe HeaderFooter
    , footer : Maybe HeaderFooter
    }
