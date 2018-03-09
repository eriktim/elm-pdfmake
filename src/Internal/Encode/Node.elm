module Internal.Encode.Node exposing (value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Attribute as Attribute
import Internal.Encode.Style as Style
import Internal.Encode.Table as Table
import Internal.Model.Node exposing (Node(..), TableCell(..))
import Internal.Object exposing (Value, float, int, list, object, string)
import PdfMake.Page exposing (PageBreak(..))


value : Node -> Value
value =
    object << value_



-- INTERNAL


value_ : Node -> List ( String, Value )
value_ node =
    case node of
        ColumnsNode columns ->
            ( "columns", list <| List.map value columns.columns )
                :: List.concatMap Attribute.values columns.attrs

        StackNode stack ->
            ( "stack", list <| List.map value stack.stack )
                :: List.concatMap Attribute.values stack.attrs

        OrderedListNode list_ ->
            ( "ol", list <| List.map value list_.ol )
                :: List.concatMap Attribute.values list_.attrs

        UnorderedListNode list_ ->
            ( "ul", list <| List.map value list_.ul )
                :: List.concatMap Attribute.values list_.attrs

        TableNode table ->
            let
                body =
                    table.headers
                        ++ table.body
                        |> List.map (list << List.map cellValue)
                        |> list

                table_ =
                    object
                        [ ( "headerRows", int <| List.length table.headers )
                        , ( "widths", list <| List.map Table.value table.widths )
                        , ( "body", body )
                        ]
            in
            [ ( "table", table_ ) ]
                ++ List.concatMap Attribute.values table.attrs

        TextNode text ->
            ( "text", string text.text )
                :: List.concatMap Attribute.values text.attrs
                ++ Style.values text.style

        TableOfContentsNode ->
            [ ( "unimplemented", string "<TableOfContentsNode>" ) ]

        ImageSizeNode image ->
            [ ( "image", string image.image )
            , ( "width", float <| dpi image.width )
            , ( "height", float <| dpi image.height )
            ]
                ++ List.concatMap Attribute.values image.attrs

        ImageFitNode image ->
            [ ( "image", string image.image )
            , ( "fit", list [ float <| dpi image.width, float <| dpi image.height ] )
            ]
                ++ List.concatMap Attribute.values image.attrs

        CanvasNode ->
            [ ( "unimplemented", string "<CanvasNode>" ) ]

        ReferenceNode ->
            [ ( "unimplemented", string "<ReferenceNode>" ) ]


cellValue : TableCell -> Value
cellValue cell =
    case cell of
        Cell attrs node ->
            object <| value_ node ++ List.map Table.attrValue attrs

        EmptyCell ->
            object []
