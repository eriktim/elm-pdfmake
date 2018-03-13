module PdfMake.Node
    exposing
        ( Node
        , Table
        , TableColumn
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


type alias Node f img =
    Node.Node f img


type alias Table records f img =
    { layout : List (TableLayout f)
    , records : List records
    , columns : List (TableColumn records f img)
    }


type alias TableColumn record f img =
    { header : Node.TableCell f img
    , width : TableWidth
    , cell : record -> Node.TableCell f img
    }


type alias TableLayout f =
    Node.TableLayout f


columns : List Attribute.Attribute -> List (Node.Node f img) -> Node.Node f img
columns attrs columns =
    ColumnsNode
        { columns = columns
        , attrs = attrs
        }


image : List Attribute.Attribute -> Float -> Float -> img -> Node.Node f img
image attrs width height img =
    ImageSizeNode
        { image = img
        , width = width
        , height = height
        , attrs = attrs
        }


imageFit : List Attribute.Attribute -> Float -> Float -> img -> Node.Node f img
imageFit attrs width height img =
    ImageFitNode
        { image = img
        , width = width
        , height = height
        , attrs = attrs
        }


ol : List Attribute.Attribute -> List (Node.Node f img) -> Node.Node f img
ol attrs items =
    OrderedListNode
        { ol = items
        , attrs = attrs
        }


stack : List Attribute.Attribute -> List (Node.Node f img) -> Node.Node f img
stack attrs stack =
    StackNode
        { stack = stack
        , attrs = attrs
        }


table : List Attribute.Attribute -> Table records f img -> Node.Node f img
table attrs table =
    let
        widths =
            List.map .width table.columns

        headers =
            List.map .header table.columns

        fs =
            table.columns
                |> List.map .cell

        body =
            table.records
                |> List.map (\record -> List.map (\f -> f record) fs)
    in
    TableNode
        { layout = table.layout
        , body = body
        , headers = [ headers ]
        , widths = widths
        , attrs = attrs
        }


text : List Style.Attribute -> String -> Node.Node f img
text style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = []
        }


textNode : List Attribute.Attribute -> List Style.Attribute -> String -> Node.Node f img
textNode attrs style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = attrs
        }


ul : List Attribute.Attribute -> List (Node.Node f img) -> Node.Node f img
ul attrs items =
    UnorderedListNode
        { ul = items
        , attrs = attrs
        }
