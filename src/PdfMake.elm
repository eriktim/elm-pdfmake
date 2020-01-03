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


type PdfMake layout image
    = PdfMake (Model layout image)


doc :
    PageSize
    -> { left : Float, top : Float, right : Float, bottom : Float }
    -> Maybe (Header layout image)
    -> Maybe (Footer layout image)
    -> Style.Style
    -> Dict.Dict String Style.Style
    -> List (Node layout image)
    -> PdfMake layout image
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


encode : (layout -> String) -> (image -> String) -> PdfMake layout image -> Encode.Value
encode layoutToString imageToString (PdfMake model) =
    Model.encode layoutToString imageToString model
