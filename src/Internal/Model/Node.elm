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


type Node layout image
    = ColumnsNode (Columns layout image)
    | StackNode (Stack layout image)
    | OrderedListNode (OrderedList layout image)
    | UnorderedListNode (UnorderedList layout image)
    | TableNode (Table layout image)
    | TextNode Text
    | TextArray (Texts layout image)
    | TableOfContentsNode
    | ImageSizeNode (ImageSized image)
    | ImageFitNode (ImageFitted image)
    | CanvasNode
    | ReferenceNode


type Header layout image
    = Header (Node layout image)


type Footer layout image
    = Footer (Node layout image)


type TableWidth
    = Auto
    | Fill
    | Inch Float


type alias Columns layout image =
    { columns : List (Node layout image)
    , attrs : List Attribute
    }


type alias Stack layout image =
    { stack : List (Node layout image)
    , attrs : List Attribute
    }


type alias OrderedList layout image =
    { ol : List (Node layout image)
    , attrs : List Attribute
    }


type alias UnorderedList layout image =
    { ul : List (Node layout image)
    , attrs : List Attribute
    }


type TableAttribute
    = Alignment TextAlignment
    | Border { left : Bool, top : Bool, right : Bool, bottom : Bool }
    | ColSpan Int
    | CellColor Color.Color
    | RowSpan Int


type TableCell layout image
    = Cell (List TableAttribute) (Node layout image)
    | EmptyCell


type alias Table layout image =
    { layout : Maybe layout
    , body : List (List (TableCell layout image))
    , headers : List (List (TableCell layout image))
    , widths : List TableWidth
    , attrs : List Attribute
    }


type alias Text =
    { text : String
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias Texts layout image =
    { nodes : List (Node layout image)
    , style : List Style.Attribute
    , attrs : List Attribute
    }


type alias ImageSized image =
    { image : image
    , width : Float -- TODO Maybe
    , height : Float -- TODO Maybe
    , attrs : List Attribute
    }


type alias ImageFitted image =
    { image : image
    , width : Float
    , height : Float
    , attrs : List Attribute
    }
