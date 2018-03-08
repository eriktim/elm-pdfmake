module Spec.PdfMake.Node exposing (suite)

import Color
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Attribute exposing (absolutePosition)
import PdfMake.Node exposing (..)
import Spec.Util exposing (isEqual, stringify)
import Test exposing (..)


suite : Test
suite =
    describe "attributes"
        [ test "columns" columnsSpec
        , test "image" imageSpec
        , test "imageFit" imageFitSpec
        , test "ol" olSpec
        , test "stack" stackSpec
        , test "text" textSpec
        , test "textNode" textNodeSpec
        , test "ul" ulSpec
        ]


columnsSpec =
    columns [ absolutePosition 123 456 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                columns: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """


imageSpec =
    image [ absolutePosition 123 456 ] 123 456 "data:image"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                height: 456,
                image: 'data:image',
                width: 123
              }
            ]
            """


imageFitSpec =
    imageFit [ absolutePosition 123 456 ] 123 456 "data:image"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                fit: [
                  123,
                  456
                ],
                image: 'data:image'
              }
            ]
            """


olSpec =
    ol [ absolutePosition 123 456 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                ol: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """


stackSpec =
    stack [ absolutePosition 123 456 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                stack: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """


textSpec =
    text [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                text: 'foo'
              }
            ]
            """


textNodeSpec =
    textNode [ absolutePosition 123 456 ] [] "foo"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                text: 'foo'
              }
            ]
            """


ulSpec =
    ul [ absolutePosition 123 456 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 123,
                  y: 456
                },
                ul: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """
