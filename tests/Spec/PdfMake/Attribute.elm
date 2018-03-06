module Spec.PdfMake.Attribute exposing (suite)

import Color
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Attribute exposing (..)
import PdfMake.Node exposing (textNode)
import PdfMake.Page exposing (PageBreak(..))
import Spec.Util exposing (isEqual, stringify)
import Test exposing (..)


suite : Test
suite =
    describe "attributes"
        [ test "absolutePosition" absolutePositionSpec
        , test "margins" marginsSpec
        , test "pageBreak before" pageBreakBeforeSpec
        , test "pageBreak after" pageBreakAfterSpec
        ]


absolutePositionSpec =
    textNode [ absolutePosition 1 2 ] [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
                },
                text: 'foo'
              }
            ]
            """


marginsSpec =
    textNode [ margins 1 2 3 4 ] [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                margin: [
                  72,
                  144,
                  216,
                  288
                ],
                text: 'foo'
              }
            ]
            """


pageBreakBeforeSpec =
    textNode [ pageBreak Before ] [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                pageBreak: 'before',
                text: 'foo'
              }
            ]
            """


pageBreakAfterSpec =
    textNode [ pageBreak After ] [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                pageBreak: 'after',
                text: 'foo'
              }
            ]
            """
