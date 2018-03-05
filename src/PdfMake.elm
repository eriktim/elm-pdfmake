module PdfMake
    exposing
        ( PdfMake
        , docDefinition
        , doc
        )

import PdfMake.Page exposing (PageSize(A4, LETTER))
import Internal.Encode.Model as Model
import Internal.Model exposing (Model)
import Internal.Node exposing (Node)
import Internal.Object exposing (stringify)
import Internal.Style as Style


type PdfMake
    = PdfMake Model


doc : PageSize -> ( Float, Float, Float, Float ) -> List Style.Attribute -> List Node -> PdfMake
doc pageSize margins style nodes =
    PdfMake
        { pageSize = pageSize
        , content = nodes
        , pageOrientation = Nothing
        , pageMargins = Just margins
        , defaultStyle = Just style
        }


docDefinition : PdfMake -> String
docDefinition pdf =
    case pdf of
        PdfMake pdf_ ->
            stringify <| Model.value pdf_
