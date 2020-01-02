module Internal.Encode.Node exposing (value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Attribute as Attribute
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model.Node exposing (Node(..), TableAttribute(..), TableCell(..), TableWidth(..))
import Internal.Object exposing (Value, bool, float, int, list, literal, object, string, stringify)
import PdfMake.Page exposing (PageBreak(..))


value : Node -> Value
value node =
    object <| value_ node



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
                        , ( "widths", list <| List.map widthValue table.widths )
                        , ( "body", body )
                        ]

                layout =
                    case table.layout of
                        Just layout_ ->
                            [ ( "layout", string layout_ ) ]

                        Nothing ->
                            []
            in
            ( "table", table_ )
                :: layout
                ++ List.concatMap Attribute.values table.attrs

        TextNode text ->
            ( "text", string text.text )
                :: List.concatMap Attribute.values text.attrs
                ++ Style.values text.style

        TextArray texts ->
            ( "text", list <| List.map value texts.nodes )
                :: List.concatMap Attribute.values texts.attrs
                ++ Style.values texts.style

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
            object <| value_ node ++ List.map attrValue attrs

        EmptyCell ->
            object []


attrValue : TableAttribute -> ( String, Value )
attrValue attr =
    case attr of
        Alignment v ->
            ( "alignment", Page.textAlignment v )

        Border { left, top, right, bottom } ->
            ( "border", list <| List.map bool [ left, top, right, bottom ] )

        ColSpan v ->
            ( "colSpan", int v )

        CellColor color ->
            ( "fillColor", Color.value color )

        RowSpan v ->
            ( "rowSpan", int v )


widthValue : TableWidth -> Value
widthValue width =
    case width of
        Auto ->
            string "auto"

        Fill ->
            string "*"

        Inch v ->
            float (dpi v)
