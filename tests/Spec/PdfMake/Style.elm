module Spec.PdfMake.Style exposing (suite)

import Color
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Node exposing (text)
import PdfMake.Page exposing (TextAlignment(..))
import PdfMake.Style exposing (..)
import Spec.Util exposing (isEqual, stringify)
import Test exposing (..)


suite : Test
suite =
    describe "style attributes"
        [ test "alignment" alignmentSpec
        , test "bold" boldSpec
        , test "color" colorSpec
        , test "font" fontSpec
        , test "fontSize" fontSizeSpec
        , test "italic" italicSpec
        , test "lineHeight" lineHeightSpec
        ]


alignmentSpec =
    text [ alignment Left ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                alignment: 'left',
                text: 'foo'
              }
            ]
            """


boldSpec =
    text [ bold ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                bold: true,
                text: 'foo'
              }
            ]
            """


colorSpec =
    text [ color Color.red ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                color: '#cc0000',
                text: 'foo'
              }
            ]
            """


fontSpec =
    text [ font "MyFont" ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                font: 'MyFont',
                text: 'foo'
              }
            ]
            """


fontSizeSpec =
    text [ fontSize 123 ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                fontSize: 123,
                text: 'foo'
              }
            ]
            """


italicSpec =
    text [ italic ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                italics: true,
                text: 'foo'
              }
            ]
            """


lineHeightSpec =
    text [ lineHeight 55 ] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                lineHeight: 55,
                text: 'foo'
              }
            ]
            """
