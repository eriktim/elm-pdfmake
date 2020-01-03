module PdfMake.Node exposing
    ( Footer
    , Header
    , Node
    , Table
    , TableColumn
    , columns
    , footer
    , header
    , image
    , imageFit
    , ol
    , stack
    , table
    , text
    , textArray
    , textNode
    , ul
    )

import Internal.Model.Attribute as Attribute
import Internal.Model.Node as Node exposing (Node(..), TableWidth)
import Internal.Model.Style as Style


type alias Node =
    Node.Node


type alias Header =
    Node.Header


type alias Footer =
    Node.Footer


type alias Table record =
    { layout : Maybe String
    , records : List record
    , columns : List (TableColumn record)
    }


type alias TableColumn record =
    { header : Node.TableCell
    , width : TableWidth
    , cell : record -> Node.TableCell
    }


header : Node.Node -> Node.Header
header =
    Node.Header


footer : Node.Node -> Node.Footer
footer =
    Node.Footer


columns : List Attribute.Attribute -> List Node.Node -> Node.Node
columns attrs columns_ =
    ColumnsNode
        { columns = columns_
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
stack attrs stack_ =
    StackNode
        { stack = stack_
        , attrs = attrs
        }


table : List Attribute.Attribute -> Table records -> Node.Node
table attrs table_ =
    let
        widths =
            List.map .width table_.columns

        headers =
            List.map .header table_.columns

        fs =
            table_.columns
                |> List.map .cell

        body =
            table_.records
                |> List.map (\record -> List.map (\f -> f record) fs)
    in
    TableNode
        { layout = table_.layout
        , body = body
        , headers = [ headers ]
        , widths = widths
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


textArray : List Attribute.Attribute -> List Style.Attribute -> List Node.Node -> Node.Node
textArray attrs style nodes =
    TextArray
        { nodes = nodes
        , style = style
        , attrs = attrs
        }


ul : List Attribute.Attribute -> List Node.Node -> Node.Node
ul attrs items =
    UnorderedListNode
        { ul = items
        , attrs = attrs
        }
