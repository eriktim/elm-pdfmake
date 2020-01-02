module Internal.Encode.Node exposing (encode)

import Internal.Encode exposing (dpi)
import Internal.Encode.Attribute as Attribute
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model.Node exposing (Node(..), TableAttribute(..), TableCell(..), TableWidth(..))
import Json.Encode as Encode
import PdfMake.Page exposing (PageBreak(..))


encode : Node -> Encode.Value
encode node =
    Encode.object <| value_ node



-- INTERNAL


value_ : Node -> List ( String, Encode.Value )
value_ node =
    case node of
        ColumnsNode columns ->
            ( "columns", Encode.list encode columns.columns )
                :: List.concatMap Attribute.encode columns.attrs

        StackNode stack ->
            ( "stack", Encode.list encode stack.stack )
                :: List.concatMap Attribute.encode stack.attrs

        OrderedListNode list_ ->
            ( "ol", Encode.list encode list_.ol )
                :: List.concatMap Attribute.encode list_.attrs

        UnorderedListNode list_ ->
            ( "ul", Encode.list encode list_.ul )
                :: List.concatMap Attribute.encode list_.attrs

        TableNode table ->
            let
                body =
                    table.headers
                        ++ table.body
                        |> Encode.list (Encode.list cellValue)

                table_ =
                    Encode.object
                        [ ( "headerRows", Encode.int <| List.length table.headers )
                        , ( "widths", Encode.list widthValue table.widths )
                        , ( "body", body )
                        ]

                layout =
                    case table.layout of
                        Just layout_ ->
                            [ ( "layout", Encode.string layout_ ) ]

                        Nothing ->
                            []
            in
            ( "table", table_ )
                :: layout
                ++ List.concatMap Attribute.encode table.attrs

        TextNode text ->
            ( "text", Encode.string text.text )
                :: List.concatMap Attribute.encode text.attrs
                ++ Style.values text.style

        TextArray texts ->
            ( "text", Encode.list encode texts.nodes )
                :: List.concatMap Attribute.encode texts.attrs
                ++ Style.values texts.style

        TableOfContentsNode ->
            [ ( "unimplemented", Encode.string "<TableOfContentsNode>" ) ]

        ImageSizeNode image ->
            [ ( "image", Encode.string image.image )
            , ( "width", Encode.float <| dpi image.width )
            , ( "height", Encode.float <| dpi image.height )
            ]
                ++ List.concatMap Attribute.encode image.attrs

        ImageFitNode image ->
            [ ( "image", Encode.string image.image )
            , ( "fit", Encode.list identity [ Encode.float <| dpi image.width, Encode.float <| dpi image.height ] )
            ]
                ++ List.concatMap Attribute.encode image.attrs

        CanvasNode ->
            [ ( "unimplemented", Encode.string "<CanvasNode>" ) ]

        ReferenceNode ->
            [ ( "unimplemented", Encode.string "<ReferenceNode>" ) ]


cellValue : TableCell -> Encode.Value
cellValue cell =
    case cell of
        Cell attrs node ->
            Encode.object <| value_ node ++ List.map attrValue attrs

        EmptyCell ->
            Encode.object []


attrValue : TableAttribute -> ( String, Encode.Value )
attrValue attr =
    case attr of
        Alignment v ->
            ( "alignment", Page.encodeTextAlignment v )

        Border { left, top, right, bottom } ->
            ( "border", Encode.list Encode.bool [ left, top, right, bottom ] )

        ColSpan v ->
            ( "colSpan", Encode.int v )

        CellColor color ->
            ( "fillColor", Color.encode color )

        RowSpan v ->
            ( "rowSpan", Encode.int v )


widthValue : TableWidth -> Encode.Value
widthValue width =
    case width of
        Auto ->
            Encode.string "auto"

        Fill ->
            Encode.string "*"

        Inch v ->
            Encode.float (dpi v)
