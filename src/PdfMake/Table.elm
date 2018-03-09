module PdfMake.Table
    exposing
        ( Width
        , align
        , autoWidth
        , border
        , cell
        , cell_
        , colSpan
        , defaultBorder
        , emptyCell
        , fillColor
        , fillWidth
        , lineColorHorizontal
        , lineColorVertical
        , lineWidthHorizontal
        , lineWidthVertical
        , paddingBottom
        , paddingLeft
        , paddingRight
        , paddingTop
        , rowSpan
        , width
        )

import Color
import Internal.Encode exposing (dpi)
import Internal.Encode.Node as Node
import Internal.Model.Function exposing (LineColor(..), LineWidth(..), Padding(..))
import Internal.Model.Node exposing (Node(TextNode), TableAttribute(..), TableCell(..))
import Internal.Model.Table as Table exposing (Layout(..), Width(..))
import PdfMake.Page exposing (TextAlignment)


type alias Width =
    Table.Width


align : TextAlignment -> TableAttribute
align =
    Alignment


autoWidth : Width
autoWidth =
    Auto


border : ( Bool, Bool, Bool, Bool ) -> TableAttribute
border =
    Border


cell : List TableAttribute -> Node -> TableCell
cell =
    Cell


cell_ : String -> TableCell
cell_ text =
    Cell [] <|
        TextNode
            { text = text
            , style = []
            , attrs = []
            }


colSpan : Int -> TableAttribute
colSpan =
    ColSpan


defaultBorder : Bool -> Layout
defaultBorder =
    DefaultBorder


emptyCell : TableCell
emptyCell =
    EmptyCell


fillWidth : Width
fillWidth =
    Fill


cellColor : Color.Color -> TableAttribute
cellColor =
    CellColor


fillColor : String -> Layout
fillColor body =
    FillColor 
            { values = []
            , body = body
            }
lineColorHorizontal : String -> Layout
lineColorHorizontal body =
    LineColorHorizontal <|
        LineColor
            { values = []
            , body = body
            }


lineColorVertical : String -> Layout
lineColorVertical body =
    LineColorVertical <|
        LineColor
            { values = []
            , body = body
            }


lineWidthHorizontal : String -> Layout
lineWidthHorizontal body =
    LineWidthHorizontal <|
        LineWidth
            { values = []
            , body = body
            }


lineWidthVertical : String -> Layout
lineWidthVertical body =
    LineWidthVertical <|
        LineWidth
            { values = []
            , body = body
            }


paddingBottom : String -> Layout
paddingBottom body =
    PaddingBottom <|
        Padding
            { values = []
            , body = body
            }


paddingLeft : String -> Layout
paddingLeft body =
    PaddingLeft <|
        Padding
            { values = []
            , body = body
            }


paddingRight : String -> Layout
paddingRight body =
    PaddingRight <|
        Padding
            { values = []
            , body = body
            }


paddingTop : String -> Layout
paddingTop body =
    PaddingTop <|
        Padding
            { values = []
            , body = body
            }


rowSpan : Int -> TableAttribute
rowSpan =
    RowSpan


width : Float -> Width
width =
    Inch
