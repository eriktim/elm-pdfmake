module PdfMake.Function
    exposing
        ( Footer
        , Header
        , footerFunction
        , headerFunction
        )

import Internal.Encode.Node as Node
import Internal.Model.Node as Model exposing (Footer(..), NodeFunction(NodeFunction), Header(..), Node)


type alias Header f img =
    Model.Header f img


type alias Footer f img =
    Model.Footer f img


footerFunction : f -> List (Node f img) -> Footer f img
footerFunction function nodes =
    Footer <|
        NodeFunction
            { args = nodes
            , function = function
            }


headerFunction : f -> List (Node f img) -> Header f img
headerFunction function nodes =
    Header <|
        NodeFunction
            { args = nodes
            , function = function
            }
