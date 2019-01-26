module Spec.Util exposing (isEqual, stringify)

import Expect exposing (Expectation)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Node exposing (Node)
import PdfMake.Page exposing (PageSize(..))


isEqual : String -> String -> (() -> Expectation)
isEqual expected result =
    \_ -> Expect.equal (escape result) (escape expected)


stringify : Node a -> String
stringify node =
    let
        pdf =
            doc A4
                ( 1, 1, 1, 1 )
                []
                [ node
                ]

        lines =
            String.lines <| docDefinition pdf
    in
    lines
        |> (List.reverse << List.drop 10 << List.reverse)
        |> List.drop 1
        |> List.map (String.dropLeft 2)
        |> String.join (String.fromChar '\n')
        |> String.dropRight 1



-- INTERNAL


escape : String -> String
escape =
    String.filter ((/=) ' ') << String.trim
