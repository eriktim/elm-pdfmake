module Spec.Util exposing (stringify)

import PdfMake exposing (doc, docDefinition)
import PdfMake.Node exposing (Node)
import PdfMake.Page exposing (PageSize(A4))


stringify : Node -> String
stringify node =
    let
        pdf =
            doc A4
                ( 1, 1, 1, 1 )
                []
                [ node
                ]

        str =
            docDefinition pdf
    in
        str
            |> String.dropRight (String.length "],defaultStyle: {}}")
            |> String.dropLeft (String.length "{pageSize: 'A4',pageOrientation: 'portrait',pageMargins: [72,72,72,72],content: [")
