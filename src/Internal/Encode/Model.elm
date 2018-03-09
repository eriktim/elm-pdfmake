module Internal.Encode.Model exposing (value)

import Internal.Encode.Node as Node
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model exposing (Model)
import Internal.Model.Function exposing (HeaderFooter(..))
import Internal.Object exposing (Value, list, literal, object, stringify)
import PdfMake.Function exposing (currentPageArg, pageCountArg, pageSizeArg)
import PdfMake.Page exposing (PageOrientation(..))


value : Model -> Value
value model =
    object
        [ ( "pageSize", Page.pageSize model.pageSize )
        , ( "pageOrientation", Page.pageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
        , ( "pageMargins", Page.pageMargins <| Maybe.withDefault ( 1, 1, 1, 1 ) model.pageMargins )
        , ( "content", list <| List.map Node.value model.content )
        , ( "defaultStyle", Style.value <| Maybe.withDefault [] model.defaultStyle )
        , ( "header", Maybe.withDefault (literal "undefined") <| Maybe.map headerFooter model.header )
        , ( "footer", Maybe.withDefault (literal "undefined") <| Maybe.map headerFooter model.footer )
        ]



-- INTERNAL


headerFooter : HeaderFooter -> Value
headerFooter hf =
    let
        function =
            case hf of
                Header fn ->
                    fn

                Footer fn ->
                    fn

        nodes =
            function.values
                |> List.map stringify
                |> List.indexedMap (\index value -> "const $node" ++ (toString <| index + 1) ++ " = " ++ value ++ ";")
                |> String.join " "
    in
    literal <|
        "("
            ++ currentPageArg
            ++ ", "
            ++ pageCountArg
            ++ ", "
            ++ pageSizeArg
            ++ ") => {"
            ++ nodes
            ++ function.body
            ++ "}"
