module PdfMake
    exposing
        ( PdfMake
        , doc
        , docDefinition
        )

import Internal.Encode.Model as Model
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer, Header, Node)
import Internal.Model.Style as Style
import Internal.Object exposing (stringify)
import PdfMake.Page exposing (PageSize(A4, LETTER))


type PdfMake f
    = PdfMake (Model f)


doc :
    PageSize
    -> ( Float, Float, Float, Float )
    -> Maybe (Header f)
    -> Maybe (Footer f)
    -> List Style.Attribute
    -> List (Node f)
    -> PdfMake f
doc pageSize margins header footer style nodes =
    PdfMake
        { pageSize = pageSize
        , content = nodes
        , pageOrientation = Nothing
        , pageMargins = Just margins
        , defaultStyle = Just style
        , header = header
        , footer = footer
        }


docDefinition : (f -> String) -> PdfMake f -> String
docDefinition fn pdf =
    case pdf of
        PdfMake model ->
            stringify <| Model.value fn model
