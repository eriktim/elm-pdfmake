module Internal.Encode.Model exposing (encode)

import Internal.Encode.Node as Node
import Internal.Encode.Page as Page
import Internal.Encode.Style as Style
import Internal.Model exposing (Model)
import Internal.Model.Node exposing (Footer(..), Header(..))
import Json.Encode as Encode
import PdfMake.Page exposing (PageOrientation(..))


encode : (layout -> String) -> (image -> String) -> Model layout image -> Encode.Value
encode layoutToString imageToString model =
    let
        encodeHeader (Header node) =
            Node.encode layoutToString imageToString node

        encodeFooter (Footer node) =
            Node.encode layoutToString imageToString node
    in
    Encode.object
        [ ( "pageSize", Page.encodePageSize model.pageSize )
        , ( "pageOrientation", Page.encodePageOrientation <| Maybe.withDefault Portrait model.pageOrientation )
        , ( "pageMargins", Page.encodePageMargins <| Maybe.withDefault { left = 1, top = 1, right = 1, bottom = 1 } model.pageMargins )
        , ( "content", Encode.list (Node.encode layoutToString imageToString) model.content )
        , ( "defaultStyle", Style.encode <| Maybe.withDefault [] model.defaultStyle )
        , ( "styles", Encode.dict identity Style.encode model.styles )
        , ( "header", Maybe.withDefault Encode.null <| Maybe.map encodeHeader model.header )
        , ( "footer", Maybe.withDefault Encode.null <| Maybe.map encodeFooter model.footer )
        ]
