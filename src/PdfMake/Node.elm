module PdfMake.Node
    exposing
        ( Node
        , TableLayout
        , columns
        , image
        , imageFit
        , ol
        , stack
        , table
        , text
        , textNode
        , ul
        )

import Internal.Model.Attribute as Attribute
import Internal.Model.Node as Node exposing (Node(..), TableLayout, TableWidth)
import Internal.Model.Style as Style


type alias Node f =
    Node.Node f


type alias TableLayout f =
    Node.TableLayout f


columns : List Attribute.Attribute -> List (Node.Node f) -> Node.Node f
columns attrs columns =
    ColumnsNode
        { columns = columns
        , attrs = attrs
        }


image : List Attribute.Attribute -> Float -> Float -> String -> Node.Node f
image attrs width height dataUrl =
    ImageSizeNode
        { image = dataUrl
        , width = width
        , height = height
        , attrs = attrs
        }


imageFit : List Attribute.Attribute -> Float -> Float -> String -> Node.Node f
imageFit attrs width height dataUrl =
    ImageFitNode
        { image = dataUrl
        , width = width
        , height = height
        , attrs = attrs
        }


ol : List Attribute.Attribute -> List (Node.Node f) -> Node.Node f
ol attrs items =
    OrderedListNode
        { ol = items
        , attrs = attrs
        }


stack : List Attribute.Attribute -> List (Node.Node f) -> Node.Node f
stack attrs stack =
    StackNode
        { stack = stack
        , attrs = attrs
        }


table : List Attribute.Attribute -> List (TableLayout f) -> List TableWidth -> List (List (Node.TableCell f)) -> List (List (Node.TableCell f)) -> Node.Node f
table attrs layout widths headers body =
    TableNode
        { layout = layout
        , body = body
        , headers = headers
        , widths = widths
        , attrs = attrs
        }


text : List Style.Attribute -> String -> Node.Node f
text style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = []
        }


textNode : List Attribute.Attribute -> List Style.Attribute -> String -> Node.Node f
textNode attrs style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = attrs
        }


ul : List Attribute.Attribute -> List (Node.Node f) -> Node.Node f
ul attrs items =
    UnorderedListNode
        { ul = items
        , attrs = attrs
        }
