module Spec.PdfMake.Style exposing (suite)

import Color
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Node exposing (text)
import PdfMake.Style exposing (..)
import Spec.Util exposing (stringify)


suite : Test
suite =
    let
        bold_ =
            stringify <| text [ bold ] "foo"

        color_ =
            stringify <| text [ color Color.red ] "foo"

        font_ =
            stringify <| text [ font "MyFont" ] "foo"

        fontSize_ =
            stringify <| text [ fontSize 123 ] "foo"

        italic_ =
            stringify <| text [ italic ] "foo"

        lineHeight_ =
            stringify <| text [ lineHeight 55 ] "foo"
    in
        describe "style attributes"
            [ test "bold" <| \_ -> Expect.equal bold_ "{text: 'foo',bold: true}"
            , test "color" <| \_ -> Expect.equal color_ "{text: 'foo',color: '#bf0000'}"
            , test "font" <| \_ -> Expect.equal font_ "{text: 'foo',font: 'MyFont'}"
            , test "fontSize" <| \_ -> Expect.equal fontSize_ "{text: 'foo',fontSize: 123}"
            , test "italic" <| \_ -> Expect.equal italic_ "{text: 'foo',italics: true}"
            , test "lineHeight" <| \_ -> Expect.equal lineHeight_ "{text: 'foo',lineHeight: 55}"
            ]
