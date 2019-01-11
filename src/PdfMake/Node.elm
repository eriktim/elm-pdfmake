module PdfMake.Node exposing
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


type alias Node f =
    Node.Node f


type alias Table records f =
    { layout : List (TableLayout f)
    , records : List records
    , columns : List (TableColumn records f)
    }


type alias TableColumn record f =
    { header : Node.TableCell f
    , width : TableWidth
    , cell : record -> Node.TableCell f
    }


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


table : List Attribute.Attribute -> Table records f -> Node.Node f
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
