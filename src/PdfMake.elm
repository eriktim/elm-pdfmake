module PdfMake
    exposing
        ( PdfMake
        , doc
        , docDefinition
        )

import Internal.Encode.Model as Model
import Internal.Model exposing (Model)
import Internal.Model.Function exposing (HeaderFooter)
import Internal.Model.Node exposing (Node)
import Internal.Model.Style as Style
import Internal.Object exposing (stringify)
import PdfMake.Page exposing (PageSize(A4, LETTER))


type PdfMake
    = PdfMake Model


doc : PageSize -> ( Float, Float, Float, Float ) -> Maybe HeaderFooter -> Maybe HeaderFooter -> List Style.Attribute -> List Node -> PdfMake
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


docDefinition : PdfMake -> String
docDefinition pdf =
    case pdf of
        PdfMake pdf_ ->
            stringify <| Model.value pdf_
