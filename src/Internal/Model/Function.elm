module Internal.Model.Function exposing (HeaderFooter(..))

import Internal.Model.Node exposing (Node)


type alias Function =
    { nodes : List Node
    , body : String
    }


type HeaderFooter
    = Header Function
    | Footer Function
