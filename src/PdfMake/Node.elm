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


type alias Node layout image =
    Node.Node layout image


type alias Header layout image =
    Node.Header layout image


type alias Footer layout image =
    Node.Footer layout image


type alias Table layout image record =
    { layout : Maybe layout
    , records : List record
    , columns : List (TableColumn layout image record)
    }


type alias TableColumn layout image record =
    { header : Node.TableCell layout image
    , width : TableWidth
    , cell : record -> Node.TableCell layout image
    }


header : Node.Node layout image -> Node.Header layout image
header =
    Node.Header


footer : Node.Node layout image -> Node.Footer layout image
footer =
    Node.Footer


columns : List Attribute.Attribute -> List (Node.Node layout image) -> Node.Node layout image
columns attrs columns_ =
    ColumnsNode
        { columns = columns_
        , attrs = attrs
        }


image : List Attribute.Attribute -> Float -> Float -> image -> Node.Node layout image
image attrs width height image_ =
    ImageSizeNode
        { image = image_
        , width = width
        , height = height
        , attrs = attrs
        }


imageFit : List Attribute.Attribute -> Float -> Float -> image -> Node.Node layout image
imageFit attrs width height image_ =
    ImageFitNode
        { image = image_
        , width = width
        , height = height
        , attrs = attrs
        }


ol : List Attribute.Attribute -> List (Node.Node layout image) -> Node.Node layout image
ol attrs items =
    OrderedListNode
        { ol = items
        , attrs = attrs
        }


stack : List Attribute.Attribute -> List (Node.Node layout image) -> Node.Node layout image
stack attrs stack_ =
    StackNode
        { stack = stack_
        , attrs = attrs
        }


table : List Attribute.Attribute -> Table layout image records -> Node.Node layout image
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


text : List Style.Attribute -> String -> Node.Node layout image
text style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = []
        }


textNode : List Attribute.Attribute -> List Style.Attribute -> String -> Node.Node layout image
textNode attrs style text_ =
    TextNode
        { text = text_
        , style = style
        , attrs = attrs
        }


textArray : List Attribute.Attribute -> List Style.Attribute -> List (Node.Node layout image) -> Node.Node layout image
textArray attrs style nodes =
    TextArray
        { nodes = nodes
        , style = style
        , attrs = attrs
        }


ul : List Attribute.Attribute -> List (Node.Node layout image) -> Node.Node layout image
ul attrs items =
    UnorderedListNode
        { ul = items
        , attrs = attrs
        }
