module PdfMake.Table exposing
    ( TableCell
    , TableWidth
    , align
    , autoWidth
    , border
    , cell
    , cellColor
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
import Internal.Encode.Color as ColorEnc
import Internal.Encode.Node as Node
import Internal.Model.Node as Model exposing (Function(..), LineColor(..), LineWidth(..), Node(..), Padding(..), TableAttribute(..), TableCell(..), TableLayout(..), TableWidth(..))
import Internal.Object exposing (float, list)
import PdfMake.Page exposing (TextAlignment)


type alias TableWidth =
    Model.TableWidth


type alias TableCell f =
    Model.TableCell f


align : TextAlignment -> TableAttribute
align =
    Alignment


autoWidth : TableWidth
autoWidth =
    Auto


border : { left : Bool, top : Bool, right : Bool, bottom : Bool } -> TableAttribute
border =
    Border


cell : List TableAttribute -> Node f -> TableCell f
cell =
    Cell


cell_ : String -> TableCell f
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


defaultBorder : Bool -> TableLayout f
defaultBorder =
    DefaultBorder


emptyCell : TableCell f
emptyCell =
    EmptyCell


fillWidth : TableWidth
fillWidth =
    Fill


cellColor : Color.Color -> TableAttribute
cellColor =
    CellColor


fillColor : f -> List Color.Color -> TableLayout f
fillColor function colors =
    FillColor <|
        Function
            { args = List.map ColorEnc.value colors
            , function = function
            }


lineColorHorizontal : f -> List Color.Color -> TableLayout f
lineColorHorizontal function colors =
    LineColorHorizontal <|
        LineColor <|
            Function
                { args = List.map ColorEnc.value colors
                , function = function
                }


lineColorVertical : f -> List Color.Color -> TableLayout f
lineColorVertical function colors =
    LineColorVertical <|
        LineColor <|
            Function
                { args = List.map ColorEnc.value colors
                , function = function
                }


lineWidthHorizontal : f -> List Float -> TableLayout f
lineWidthHorizontal function widths =
    LineWidthHorizontal <|
        LineWidth <|
            Function
                { args = List.map float widths
                , function = function
                }


lineWidthVertical : f -> List Float -> TableLayout f
lineWidthVertical function widths =
    LineWidthVertical <|
        LineWidth <|
            Function
                { args = List.map float widths
                , function = function
                }


paddingBottom : f -> List Float -> TableLayout f
paddingBottom function paddings =
    PaddingBottom <|
        Padding <|
            Function
                { args = List.map float paddings
                , function = function
                }


paddingLeft : f -> List Float -> TableLayout f
paddingLeft function paddings =
    PaddingLeft <|
        Padding <|
            Function
                { args = List.map float paddings
                , function = function
                }


paddingRight : f -> List Float -> TableLayout f
paddingRight function paddings =
    PaddingRight <|
        Padding <|
            Function
                { args = List.map float paddings
                , function = function
                }


paddingTop : f -> List Float -> TableLayout f
paddingTop function paddings =
    PaddingTop <|
        Padding <|
            Function
                { args = List.map float paddings
                , function = function
                }


rowSpan : Int -> TableAttribute
rowSpan =
    RowSpan


width : Float -> TableWidth
width =
    Inch
