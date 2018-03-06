module Spec.PdfMake.Node exposing (suite)

import Color
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Attribute exposing (absolutePosition)
import PdfMake.Node exposing (..)
import PdfMake.Table exposing (autoWidth, border, cell, cell_, colSpan, fillColor, fillWidth, rowSpan, width)
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
        , test "table" tableSpec
        , test "text" textSpec
        , test "textNode" textNodeSpec
        , test "ul" ulSpec
        ]


columnsSpec =
    columns [ absolutePosition 1 2 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
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
    image [ absolutePosition 1 2 ] 123 456 "data:image"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
                },
                height: 456,
                image: 'data:image',
                width: 123
              }
            ]
            """


imageFitSpec =
    imageFit [ absolutePosition 1 2 ] 123 456 "data:image"
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
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
    ol [ absolutePosition 1 2 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
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
    stack [ absolutePosition 1 2 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
                },
                stack: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """


tableSpec =
    let
        attrs =
            [ fillColor Color.blue, colSpan 1, rowSpan 1, border ( False, True, False, False ) ]
    in
    table [ absolutePosition 1 2 ]
        [ autoWidth, fillWidth, width 12 ]
        [ [ cell_ "header1", cell_ "header2", cell_ "header3" ]
        ]
        [ [ cell attrs <| text [] "foo", cell_ "foz", cell_ "for" ]
        , [ cell_ "bar", cell_ "baz", cell_ "baa" ]
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
                },
                table: {
                  body: [
                    [
                      {
                        text: 'header1'
                      },
                      {
                        text: 'header2'
                      },
                      {
                        text: 'header3'
                      }
                    ],
                    [
                      {
                        border: [
                          false,
                          true,
                          false,
                          false
                        ],
                        colSpan: 1,
                        fillColor: '#3465a4',
                        rowSpan: 1,
                        text: 'foo'
                      },
                      {
                        text: 'foz'
                      },
                      {
                        text: 'for'
                      }
                    ],
                    [
                      {
                        text: 'bar'
                      },
                      {
                        text: 'baz'
                      },
                      {
                        text: 'baa'
                      }
                    ]
                  ],
                  headerRows: 1,
                  widths: [
                    'auto',
                    '*',
                    864
                  ]
                }
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


ulSpec =
    ul [ absolutePosition 1 2 ]
        [ text [] "foo"
        ]
        |> stringify
        |> isEqual
            """
            content: [
              {
                absolutePosition: {
                  x: 72,
                  y: 144
                },
                ul: [
                  {
                    text: 'foo'
                  }
                ]
              }
            ]
            """
