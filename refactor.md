Document
document : List DocumentAttr -> List Node -> Document
build : (f -> String) -> Document -> String

DocumentAttr
pageMargins : Float -> Float -> Float -> Float -> DocumentAttr
defaultStyle : List StyleAttr -> DocumentAttr
landscape : DocumentAttr
portrait : DocumentAttr
{a,b,c}{1,2,3,4,5,6,7,8,9,10} : DocumentAttr
a0x{2,4} : DocumentAttr
[s]ra{0,1,2,3,4} : DocumentAttr
{executive,folio,legal,letter,tabloid} : DocumentAttr

StyleAttr -- TextAttr
{left,right,center,justified} : StyleAttr
{bold,italic} : StyleAttr
color : Color.Color -> StyleAttr
font : String -> StyleAttr
fontSize : Int -> StyleAttr
lineHeight : Float -> StyleAttr

NodeAttr
absolutePosition : Float -> Float -> NodeAttr
margins : Float -> Float -> Float -> Float -> NodeAttr
pageBreakBefore : NodeAttr
pageBreakAfter : NodeAttr

Node
text : List StyleAttr -> String -> Node
textArray: List StyleAttr -> List String -> Node
textNode: List NodeAttr -> Text -> Node
columns : List NodeAttr -> List Node -> Node
image[Fit] : List NodeAttr -> Float -> Float -> String -> Node
[un]orderedList : List NodeAttr -> List Node -> Node
stack : List NodeAttr -> List Node -> Node
table : List NodeAttr -> Table -> Node
cell : List TableAttr -> Node -> Node

Table, TableAttr, TableLayout, TableWidth -- new file
width{Auto,Fill} : TableWidth
width : Float -> TableWidth
{left,right,center,justified} : TableAttr
border : Bool -> Bool -> Bool -> Bool -> TableAttr
columnSpan : Int -> TableAttr
rowSpan : Int -> TableAttr
backgroundColor : Color.Color -> TableAttr
defaultBorder : Bool -> TableLayout

Function -- new file
header : f -> List (Node f) -> DocumentAttr
footer : f -> List (Node f) -> DocumentAttr
{fillColor,lineColor{Horizontal,Vertical}} : f -> List Color.Color -> TableLayout
{lineWidth{Horizontal,Vertical},padding{Left,Right,Top,Bottom}} : f -> List Float -> TableLayout
