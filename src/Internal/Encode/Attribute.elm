module Internal.Encode.Attribute exposing (encode)

import Internal.Encode exposing (dpi)
import Internal.Encode.Style as Style
import Internal.Model.Attribute exposing (Attribute(..))
import Json.Encode as Encode
import PdfMake.Page exposing (PageBreak(..))


encode : Attribute -> List ( String, Encode.Value )
encode attr =
    case attr of
        AbsolutePosition pos ->
            [ ( "absolutePosition"
              , Encode.object
                    [ ( "x", Encode.float <| dpi pos.x )
                    , ( "y", Encode.float <| dpi pos.y )
                    ]
              )
            ]

        Margins margins ->
            [ ( "margin", Encode.list (Encode.float << dpi) [ margins.left, margins.top, margins.right, margins.bottom ] ) ]

        PageBreak break ->
            [ ( "pageBreak", encodePageBreak break ) ]

        Style style ->
            Style.values style


encodePageBreak : PageBreak -> Encode.Value
encodePageBreak break =
    Encode.string <|
        case break of
            Before ->
                "before"

            After ->
                "after"
