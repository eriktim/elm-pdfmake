module Internal.Model.Function
    exposing
        ( Function
        , HeaderFooter(..)
        , LineColor(..)
        , LineWidth(..)
        , Padding(..)
        )

import Internal.Object exposing (Value)


type alias Function =
    { values : List Value
    , body : String
    }


type HeaderFooter
    = Header Function
    | Footer Function


type LineWidth
    = LineWidth Function


type LineColor
    = LineColor Function


type Padding
    = Padding Function
