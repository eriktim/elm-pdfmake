module Internal.Encode.Page exposing
    ( pageMargins
    , pageOrientation
    , pageSize
    , textAlignment
    )

import Internal.Encode exposing (dpi)
import Internal.Object exposing (Value, float, list, object, string)
import PdfMake.Page exposing (PageOrientation(..), PageSize(..), TextAlignment(..))


pageOrientation : PageOrientation -> Value
pageOrientation orientation =
    string <|
        case orientation of
            Landscape ->
                "landscape"

            Portrait ->
                "portrait"


pageMargins : ( Float, Float, Float, Float ) -> Value
pageMargins ( l, t, r, b ) =
    list <| List.map (float << dpi) [ l, t, r, b ]


pageSize : PageSize -> Value
pageSize size =
    string <|
        case size of
            A0x4 ->
                "4A0"

            A0x2 ->
                "2A0"

            A0 ->
                "A0"

            A1 ->
                "A1"

            A2 ->
                "A2"

            A3 ->
                "A3"

            A4 ->
                "A4"

            A5 ->
                "A5"

            A6 ->
                "A6"

            A7 ->
                "A7"

            A8 ->
                "A8"

            A9 ->
                "A9"

            A10 ->
                "A10"

            B0 ->
                "B0"

            B1 ->
                "B1"

            B2 ->
                "B2"

            B3 ->
                "B3"

            B4 ->
                "B4"

            B5 ->
                "B5"

            B6 ->
                "B6"

            B7 ->
                "B7"

            B8 ->
                "B8"

            B9 ->
                "B9"

            B10 ->
                "B10"

            C0 ->
                "C0"

            C1 ->
                "C1"

            C2 ->
                "C2"

            C3 ->
                "C3"

            C4 ->
                "C4"

            C5 ->
                "C5"

            C6 ->
                "C6"

            C7 ->
                "C7"

            C8 ->
                "C8"

            C9 ->
                "C9"

            C10 ->
                "C10"

            RA0 ->
                "RA0"

            RA1 ->
                "RA1"

            RA2 ->
                "RA2"

            RA3 ->
                "RA3"

            RA4 ->
                "RA4"

            SRA0 ->
                "SRA0"

            SRA1 ->
                "SRA1"

            SRA2 ->
                "SRA2"

            SRA3 ->
                "SRA3"

            SRA4 ->
                "SRA4"

            EXECUTIVE ->
                "EXECUTIVE"

            FOLIO ->
                "FOLIO"

            LEGAL ->
                "LEGAL"

            LETTER ->
                "LETTER"

            TABLOID ->
                "TABLOID"


textAlignment : TextAlignment -> Value
textAlignment alignment =
    string <|
        case alignment of
            Left ->
                "left"

            Right ->
                "right"

            Centered ->
                "centered"

            Justified ->
                "justified"
