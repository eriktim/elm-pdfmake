module Internal.Model.Node exposing
    ( Footer(..)
    , Header(..)
    , Node(..)
    , Table
    , TableAttribute(..)
    , TableCell(..)
    , TableWidth(..)
    )

import Color
import Internal.Model.Attribute as Attribute exposing (Attribute)
import Internal.Model.Style as Style
import PdfMake.Page exposing (TextAlignment)


type Node
    = ColumnsNode Columns
    | StackNode Stack
    | OrderedListNode OrderedList
    | UnorderedListNode UnorderedList
    | TableNode Table
    | TextNode Text
    | TextArray Texts
    | TableOfContentsNode
    | ImageSizeNode ImageSized
    | ImageFitNode ImageFitted
    | CanvasNode
    | ReferenceNode


type Header
    = Header Node


type Footer
    = Footer Node


type TableWidth
    = Auto
    | Fill
    | Inch Float


type alias Columns =
    { columns : List Node
    , attrs : List Attribute
    }


type alias Stack =
    { stack : List Node
    , attrs : List Attribute
    }


type alias OrderedList =
    { ol : List Node
    , attrs : List Attribute
    }


type alias UnorderedList =
    { ul : List Node
    , attrs : List Attribute
    }


type TableAttribute
    = Alignment TextAlignment
    | Border { left : Bool, top : Bool, right : Bool, bottom : Bool }
    | ColSpan Int
    | CellColor Color.Color
    | RowSpan Int


type TableCell
    = Cell (List TableAttribute) Node
    | EmptyCell


type alias Table =
    { layout : Maybe String
    , body : List (List TableCell)
    , headers : List (List TableCell)
    , widths : List TableWidth
    , attrs : List Attribute
    }


type alias Text =
    { text : String
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias Texts =
    { nodes : List Node
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
