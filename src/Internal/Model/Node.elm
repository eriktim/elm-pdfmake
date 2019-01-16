module Internal.Model.Node exposing
    ( Footer(..)
    , Function(..)
    , Header(..)
    , LineColor(..)
    , LineWidth(..)
    , Node(..)
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


type Node f
    = ColumnsNode (Columns f)
    | StackNode (Stack f)
    | OrderedListNode (OrderedList f)
    | UnorderedListNode (UnorderedList f)
    | TableNode (Table f)
    | TextNode Text
    | TextArray (Texts f)
    | TableOfContentsNode
    | ImageSizeNode ImageSized
    | ImageFitNode ImageFitted
    | CanvasNode
    | ReferenceNode


type Function f
    = Function
        { args : List Value
        , function : f
        }
    | NodeFunction
        { args : List (Node f)
        , function : f
        }


type Header f
    = Header (Function f)


type Footer f
    = Footer (Function f)


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


type alias Columns f =
    { columns : List (Node f)
    , attrs : List Attribute
    }


type alias Stack f =
    { stack : List (Node f)
    , attrs : List Attribute
    }


type alias OrderedList f =
    { ol : List (Node f)
    , attrs : List Attribute
    }


type alias UnorderedList f =
    { ul : List (Node f)
    , attrs : List Attribute
    }


type TableAttribute
    = Alignment TextAlignment
    | Border { left : Bool, top : Bool, right : Bool, bottom : Bool }
    | ColSpan Int
    | CellColor Color.Color
    | RowSpan Int


type TableCell f
    = Cell (List TableAttribute) (Node f)
    | EmptyCell


type alias Table f =
    { layout : List (TableLayout f)
    , body : List (List (TableCell f))
    , headers : List (List (TableCell f))
    , widths : List TableWidth
    , attrs : List Attribute
    }


type alias Text =
    { text : String
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias Texts f =
    { nodes : List (Node f)
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias ImageSized =
    { image : String
    , width : Float -- TODO Maybe
    , height : Float -- TODO Maybe
    , attrs : List Attribute
    }


type alias ImageFitted =
    { image : String
    , width : Float
    , height : Float
    , attrs : List Attribute
    }
