module PdfMake.Function exposing
    ( Footer
    , Header
    , footerFunction
    , headerFunction
    )

import Internal.Encode.Node as Node
import Internal.Model.Node as Model exposing (Footer(..), Function(..), Header(..), Node)


type alias Header f =
    Model.Header f


type alias Footer f =
    Model.Footer f


footerFunction : f -> List (Node f) -> Footer f
footerFunction function nodes =
    Footer <|
        NodeFunction
            { args = nodes
            , function = function
            }


headerFunction : f -> List (Node f) -> Header f
headerFunction function nodes =
    Header <|
        NodeFunction
            { args = nodes
            , function = function
            }
