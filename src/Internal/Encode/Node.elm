module Internal.Encode.Node exposing (functionValue, value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Attribute as Attribute
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model.Node exposing (Function(..), LineColor(..), LineWidth(..), Node(..), Padding(..), TableAttribute(..), TableCell(..), TableLayout(..), TableWidth(..))
import Internal.Object exposing (Value, bool, float, int, list, literal, object, string, stringify)
import PdfMake.Page exposing (PageBreak(..))


value : (f -> String) -> Node f -> Value
value fn node =
    object <| value_ fn node


functionValue : (f -> String) -> Function f -> Value
functionValue fn function =
    let
        ( func, args ) =
            case function of
                Function f ->
                    ( fn f.function, f.args )

                NodeFunction f ->
                    ( fn f.function, List.map (value fn) f.args )

        args_ =
            String.join ", " <| List.map stringify args
    in
    literal <| func ++ "(" ++ args_ ++ ")"



-- INTERNAL


value_ : (f -> String) -> Node f -> List ( String, Value )
value_ fn node =
    case node of
        ColumnsNode columns ->
            ( "columns", list <| List.map (value fn) columns.columns )
                :: List.concatMap Attribute.values columns.attrs

        StackNode stack ->
            ( "stack", list <| List.map (value fn) stack.stack )
                :: List.concatMap Attribute.values stack.attrs

        OrderedListNode list_ ->
            ( "ol", list <| List.map (value fn) list_.ol )
                :: List.concatMap Attribute.values list_.attrs

        UnorderedListNode list_ ->
            ( "ul", list <| List.map (value fn) list_.ul )
                :: List.concatMap Attribute.values list_.attrs

        TableNode table ->
            let
                body =
                    table.headers
                        ++ table.body
                        |> List.map (list << List.map (cellValue fn))
                        |> list

                table_ =
                    object
                        [ ( "headerRows", int <| List.length table.headers )
                        , ( "widths", list <| List.map widthValue table.widths )
                        , ( "body", body )
                        ]
            in
            [ ( "table", table_ )
            , ( "layout", object <| List.map (layoutValue fn) table.layout )
            ]
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


cellValue : (f -> String) -> TableCell f -> Value
cellValue fn cell =
    case cell of
        Cell attrs node ->
            object <| value_ fn node ++ List.map attrValue attrs

        EmptyCell ->
            object []


attrValue : TableAttribute -> ( String, Value )
attrValue attr =
    case attr of
        Alignment value ->
            ( "alignment", Page.textAlignment value )

        Border ( left, top, right, bottom ) ->
            ( "border", list <| List.map bool [ left, top, right, bottom ] )

        ColSpan value ->
            ( "colSpan", int value )

        CellColor color ->
            ( "fillColor", Color.value color )

        RowSpan value ->
            ( "rowSpan", int value )


layoutValue : (f -> String) -> TableLayout f -> ( String, Value )
layoutValue fn layout =
    case layout of
        DefaultBorder value ->
            ( "defaultBorder", bool value )

        FillColor function ->
            ( "fillColor", functionValue fn function )

        LineWidthHorizontal width ->
            case width of
                LineWidth function ->
                    ( "hLineWidth", functionValue fn function )

        LineWidthVertical width ->
            case width of
                LineWidth function ->
                    ( "vLineWidth", functionValue fn function )

        LineColorHorizontal color ->
            case color of
                LineColor function ->
                    ( "hLineColor", functionValue fn function )

        LineColorVertical color ->
            case color of
                LineColor function ->
                    ( "vLineColor", functionValue fn function )

        PaddingBottom padding ->
            case padding of
                Padding function ->
                    ( "paddingBottom", functionValue fn function )

        PaddingLeft padding ->
            case padding of
                Padding function ->
                    ( "paddingLeft", functionValue fn function )

        PaddingRight padding ->
            case padding of
                Padding function ->
                    ( "paddingRight", functionValue fn function )

        PaddingTop padding ->
            case padding of
                Padding function ->
                    ( "paddingTop", functionValue fn function )


widthValue : TableWidth -> Value
widthValue width =
    case width of
        Auto ->
            string "auto"

        Fill ->
            string "*"

        Inch value ->
            float (dpi value)
