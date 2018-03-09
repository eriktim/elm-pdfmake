module Internal.Model.Node
    exposing
        ( Node(..)
        , Table
        , TableAttribute(..)
        , TableCell(..)
        )

import Color
import Internal.Model.Attribute as Attribute exposing (Attribute)
import Internal.Model.Style as Style
import Internal.Model.Table exposing (Width)
import PdfMake.Page exposing (TextAlignment)


type Node
    = ColumnsNode Columns
    | StackNode Stack
    | OrderedListNode OrderedList
    | UnorderedListNode UnorderedList
    | TableNode Table
    | TextNode Text
    | TableOfContentsNode
    | ImageSizeNode ImageSized
    | ImageFitNode ImageFitted
    | CanvasNode
    | ReferenceNode


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
    | Border ( Bool, Bool, Bool, Bool )
    | ColSpan Int
    | FillColor Color.Color
    | RowSpan Int


type TableCell
    = Cell (List TableAttribute) Node
    | EmptyCell


type alias Table =
    { body : List (List TableCell)
    , headers : List (List TableCell)
    , widths : List Width
    , attrs : List Attribute
    }


type alias Text =
    { text : String
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
