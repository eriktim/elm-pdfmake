module Internal.Encode.Node exposing (functionValue, value)

import Internal.Encode exposing (dpi)
import Internal.Encode.Attribute as Attribute
import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model.Node exposing (Function(..), LineColor(..), LineWidth(..), Node(..), NodeFunction(..), Padding(..), TableAttribute(..), TableCell(..), TableLayout(..), TableWidth(..))
import Internal.Object exposing (Value, bool, float, int, list, literal, object, string, stringify)
import PdfMake.Page exposing (PageBreak(..))


value : (f -> String) -> (img -> ( String, String )) -> Node f img -> Value
value fn img node =
    object <| value_ fn img node


functionValue : (f -> String) -> (img -> ( String, String )) -> NodeFunction f img -> Value
functionValue fn img function =
    functionValue_ fn <|
        case function of
            NodeFunction f ->
                let
                    args =
                        List.map (value fn img) f.args
                in
                Function
                    { args = args
                    , function = f.function
                    }



-- INTERNAL


value_ : (f -> String) -> (img -> ( String, String )) -> Node f img -> List ( String, Value )
value_ fn img node =
    case node of
        ColumnsNode columns ->
            ( "columns", list <| List.map (value fn img) columns.columns )
                :: List.concatMap Attribute.values columns.attrs

        StackNode stack ->
            ( "stack", list <| List.map (value fn img) stack.stack )
                :: List.concatMap Attribute.values stack.attrs

        OrderedListNode list_ ->
            ( "ol", list <| List.map (value fn img) list_.ol )
                :: List.concatMap Attribute.values list_.attrs

        UnorderedListNode list_ ->
            ( "ul", list <| List.map (value fn img) list_.ul )
                :: List.concatMap Attribute.values list_.attrs

        TableNode table ->
            let
                body =
                    table.headers
                        ++ table.body
                        |> List.map (list << List.map (cellValue fn img))
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
            [ ( "image", string <| Tuple.first (img image.image) )
            , ( "width", float <| dpi image.width )
            , ( "height", float <| dpi image.height )
            ]
                ++ List.concatMap Attribute.values image.attrs

        ImageFitNode image ->
            [ ( "image", string <| Tuple.first (img image.image) )
            , ( "fit", list [ float <| dpi image.width, float <| dpi image.height ] )
            ]
                ++ List.concatMap Attribute.values image.attrs

        CanvasNode ->
            [ ( "unimplemented", string "<CanvasNode>" ) ]

        ReferenceNode ->
            [ ( "unimplemented", string "<ReferenceNode>" ) ]


cellValue : (f -> String) -> (img -> ( String, String )) -> TableCell f img -> Value
cellValue fn img cell =
    case cell of
        Cell attrs node ->
            object <| value_ fn img node ++ List.map attrValue attrs

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
            ( "fillColor", functionValue_ fn function )

        LineWidthHorizontal width ->
            case width of
                LineWidth function ->
                    ( "hLineWidth", functionValue_ fn function )

        LineWidthVertical width ->
            case width of
                LineWidth function ->
                    ( "vLineWidth", functionValue_ fn function )

        LineColorHorizontal color ->
            case color of
                LineColor function ->
                    ( "hLineColor", functionValue_ fn function )

        LineColorVertical color ->
            case color of
                LineColor function ->
                    ( "vLineColor", functionValue_ fn function )

        PaddingBottom padding ->
            case padding of
                Padding function ->
                    ( "paddingBottom", functionValue_ fn function )

        PaddingLeft padding ->
            case padding of
                Padding function ->
                    ( "paddingLeft", functionValue_ fn function )

        PaddingRight padding ->
            case padding of
                Padding function ->
                    ( "paddingRight", functionValue_ fn function )

        PaddingTop padding ->
            case padding of
                Padding function ->
                    ( "paddingTop", functionValue_ fn function )


widthValue : TableWidth -> Value
widthValue width =
    case width of
        Auto ->
            string "auto"

        Fill ->
            string "*"

        Inch value ->
            float (dpi value)


functionValue_ : (f -> String) -> Function f -> Value
functionValue_ fn function =
    let
        ( func, args ) =
            case function of
                Function f ->
                    ( fn f.function, f.args )

        args_ =
            String.join ", " <| List.map stringify args
    in
    literal <| func ++ "(" ++ args_ ++ ")"
