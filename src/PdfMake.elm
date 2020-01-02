module PdfMake exposing
    ( PdfMake
    , doc
    , encode
    )

import Dict
import Internal.Encode.Model as Model
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer, Header, Node)
import Internal.Model.Style as Style
import Json.Encode as Encode
import PdfMake.Page exposing (PageSize(..))


type PdfMake
    = PdfMake Model


doc :
    PageSize
    -> { left : Float, top : Float, right : Float, bottom : Float }
    -> Maybe Header
    -> Maybe Footer
    -> Style.Style
    -> Dict.Dict String Style.Style
    -> List Node
    -> PdfMake
doc pageSize margins header footer style styles nodes =
    PdfMake
        { pageSize = pageSize
        , content = nodes
        , pageOrientation = Nothing
        , pageMargins = Just margins
        , defaultStyle = Just style
        , styles = styles
        , header = header
        , footer = footer
        }


encode : PdfMake -> Encode.Value
encode (PdfMake model) =
    Model.encode model
