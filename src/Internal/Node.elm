module Internal.Node
    exposing
        ( Node(..)
        )

import Internal.Attribute as Attribute exposing (Attribute)
import Internal.Style as Style


type Node
    = ColumnsNode Columns
    | StackNode Stack
    | OrderedListNode OrderedList
    | UnorderedListNode UnorderedList
    | TableNode
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


type alias UnorderedList =
    { ul : List Node
    , attrs : List Attribute
    }


type alias OrderedList =
    { ol : List Node
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
