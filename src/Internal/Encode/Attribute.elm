module Internal.Encode.Attribute exposing (values)

import PdfMake.Page exposing (PageBreak(..))
import Internal.Attribute exposing (Attribute(..))
import Internal.Encode.Encode exposing (dpi)
import Internal.Encode.Style as Style
import Internal.Object exposing (Value, list, number, object, string)


values : Attribute -> List ( String, Value )
values attr =
    case attr of
        AbsolutePosition pos ->
            [ ( "absolutePosition"
              , object
                    [ ( "x", number pos.x )
                    , ( "y", number pos.y )
                    ]
              )
            ]

        Margins margins ->
            [ ( "margin", list <| List.map (number << dpi) [ margins.left, margins.top, margins.right, margins.bottom ] ) ]

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
