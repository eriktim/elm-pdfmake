module Internal.Encode.Style exposing (encode, values)

import Internal.Encode.Color as Color
import Internal.Encode.Page as Page
import Internal.Model.Style exposing (Attribute(..))
import Json.Encode as Encode


encode : List Attribute -> Encode.Value
encode =
    Encode.object << values


values : List Attribute -> List ( String, Encode.Value )
values =
    -- RENAME FN
    List.map encodeField



-- INTERNAL


encodeField : Attribute -> ( String, Encode.Value )
encodeField attr =
    case attr of
        Bold ->
            ( "bold", Encode.bool True )

        Color color ->
            ( "color", Color.encode color )

        Font font ->
            ( "font", Encode.string font )

        FontSize size ->
            ( "fontSize", Encode.int size )

        Italic ->
            ( "italics", Encode.bool True )

        LineHeight height ->
            ( "lineHeight", Encode.float height )

        Alignment alignment ->
            ( "alignment", Page.encodeTextAlignment alignment )
