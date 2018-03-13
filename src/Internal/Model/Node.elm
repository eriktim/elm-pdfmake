module Internal.Model.Node
    exposing
        ( Footer(..)
        , Function(..)
        , Header(..)
        , LineColor(..)
        , LineWidth(..)
        , Node(..)
        , NodeFunction(..)
        , Padding(..)
        , Table
        , TableAttribute(..)
        , TableCell(..)
        , TableLayout(..)
        , TableWidth(..)
        )

import Color
import Internal.Model.Attribute as Attribute exposing (Attribute)
import Internal.Model.Style as Style
import Internal.Object exposing (Value)
import PdfMake.Page exposing (TextAlignment)


type Node f img
    = ColumnsNode (Columns f img)
    | StackNode (Stack f img)
    | OrderedListNode (OrderedList f img)
    | UnorderedListNode (UnorderedList f img)
    | TableNode (Table f img)
    | TextNode Text
    | TableOfContentsNode
    | ImageSizeNode (ImageSized img)
    | ImageFitNode (ImageFitted img)
    | CanvasNode
    | ReferenceNode


type Function f
    = Function
        { args : List Value
        , function : f
        }


type NodeFunction f img
    = NodeFunction
        { args : List (Node f img)
        , function : f
        }


type Header f img
    = Header (NodeFunction f img)


type Footer f img
    = Footer (NodeFunction f img)


type LineWidth f
    = LineWidth (Function f)


type LineColor f
    = LineColor (Function f)


type Padding f
    = Padding (Function f)


type TableWidth
    = Auto
    | Fill
    | Inch Float


type TableLayout f
    = DefaultBorder Bool
    | FillColor (Function f)
    | LineWidthHorizontal (LineWidth f)
    | LineWidthVertical (LineWidth f)
    | LineColorHorizontal (LineColor f)
    | LineColorVertical (LineColor f)
    | PaddingBottom (Padding f)
    | PaddingLeft (Padding f)
    | PaddingRight (Padding f)
    | PaddingTop (Padding f)


type alias Columns f img =
    { columns : List (Node f img)
    , attrs : List Attribute
    }


type alias Stack f img =
    { stack : List (Node f img)
    , attrs : List Attribute
    }


type alias OrderedList f img =
    { ol : List (Node f img)
    , attrs : List Attribute
    }


type alias UnorderedList f img =
    { ul : List (Node f img)
    , attrs : List Attribute
    }


type TableAttribute
    = Alignment TextAlignment
    | Border ( Bool, Bool, Bool, Bool )
    | ColSpan Int
    | CellColor Color.Color
    | RowSpan Int


type TableCell f img
    = Cell (List TableAttribute) (Node f img)
    | EmptyCell


type alias Table f img =
    { layout : List (TableLayout f)
    , body : List (List (TableCell f img))
    , headers : List (List (TableCell f img))
    , widths : List TableWidth
    , attrs : List Attribute
    }


type alias Text =
    { text : String
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias ImageSized img =
    { image : img
    , width : Float -- TODO Maybe
    , height : Float -- TODO Maybe
    , attrs : List Attribute
    }


type alias ImageFitted img =
    { image : img
    , width : Float
    , height : Float
    , attrs : List Attribute
    }
