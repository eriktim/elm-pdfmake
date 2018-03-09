module PdfMake.Function
    exposing
        ( HeaderFooter
        , currentPageArg
        , footerFunction
        , headerFunction
        , pageCountArg
        , pageSizeArg
        )

import Internal.Encode.Node as Node
import Internal.Model.Function as Function exposing (HeaderFooter(..))
import Internal.Model.Node exposing (Node)


type alias HeaderFooter =
    Function.HeaderFooter


currentPageArg : String
currentPageArg =
    "currentPage"


footerFunction : List Node -> String -> HeaderFooter
footerFunction nodes body =
    Footer
        { values = List.map Node.value nodes
        , body = body
        }


headerFunction : List Node -> String -> HeaderFooter
headerFunction nodes body =
    Header
        { values = List.map Node.value nodes
        , body = body
        }


pageCountArg : String
pageCountArg =
    "pageCount"


pageSizeArg : String
pageSizeArg =
    "pageSize"
