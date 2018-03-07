module Internal.Encode.Attribute exposing (values)

import Internal.Encode exposing (dpi)
import Internal.Encode.Style as Style
import Internal.Model.Attribute exposing (Attribute(..))
import Internal.Object exposing (Value, float, list, object, string)
import PdfMake.Page exposing (PageBreak(..))


values : Attribute -> List ( String, Value )
values attr =
    case attr of
        AbsolutePosition pos ->
            [ ( "absolutePosition"
              , object
                    [ ( "x", float pos.x )
                    , ( "y", float pos.y )
                    ]
              )
            ]

        Margins margins ->
            [ ( "margin", list <| List.map (float << dpi) [ margins.left, margins.top, margins.right, margins.bottom ] ) ]

        PageBreak break ->
            [ ( "pageBreak", pageBreak break ) ]

        Style style ->
            Style.values style


pageBreak : PageBreak -> Value
pageBreak break =
    string <|
        case break of
            Before ->
                "before"

            After ->
                "after"
