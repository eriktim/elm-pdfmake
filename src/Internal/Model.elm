module Internal.Model exposing (Model)

import Dict
import PdfMake.Page exposing (PageOrientation, PageSize)
import Internal.Model.Node exposing (Node)
import Internal.Model.Style exposing (Attribute)


type alias Model =
    { pageSize : PageSize
    , content : List Node
    , pageOrientation : Maybe PageOrientation
    , pageMargins : Maybe ( Float, Float, Float, Float )
    , defaultStyle : Maybe (List Attribute)

    --, header : Maybe Header
    --, footer : Maybe Footer
    }
