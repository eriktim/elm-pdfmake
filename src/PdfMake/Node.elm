module PdfMake.Node
    exposing
        ( Node
        , columns
        , image
        , imageFit
        , ol
        , stack
        , text
        , textNode
        , ul
        )

import Internal.Model.Node as Node exposing (Node(..))
import Internal.Model.Attribute as Attribute
import Internal.Model.Style as Style


type alias Node =
    Node.Node


columns : List Attribute.Attribute -> List Node.Node -> Node.Node
columns attrs columns =
    ColumnsNode
        { columns = columns
        , attrs = attrs
        }


image : List Attribute.Attribute -> Float -> Float -> String -> Node.Node
image attrs width height dataUrl =
    ImageSizeNode
        { image = dataUrl
        , width = width
        , height = height
        , attrs = attrs
        }


imageFit : List Attribute.Attribute -> Float -> Float -> String -> Node.Node
imageFit attrs width height dataUrl =
    ImageFitNode
        { image = dataUrl
        , width = width
        , height = height
        , attrs = attrs
        }


ol : List Attribute.Attribute -> List Node.Node -> Node.Node
ol attrs items =
    OrderedListNode
        { ol = items
        , attrs = attrs
        }


stack : List Attribute.Attribute -> List Node.Node -> Node.Node
stack attrs stack =
    StackNode
        { stack = stack
        , attrs = attrs
        }


text : List Style.Attribute -> String -> Node.Node
text style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = []
        }


textNode : List Attribute.Attribute -> List Style.Attribute -> String -> Node.Node
textNode attrs style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = attrs
        }


ul : List Attribute.Attribute -> List Node.Node -> Node.Node
ul attrs items =
    UnorderedListNode
        { ul = items
        , attrs = attrs
        }
