module Spec.PdfMake exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import PdfMake exposing (doc, docDefinition)
import PdfMake.Node exposing (text)
import PdfMake.Page exposing (PageSize(..))
import Spec.Util exposing (isEqual)


suite : Test
suite =
    let
        pdf =
            doc A4
                ( 1, 1, 1, 1 )
                []
                [ text [] "First paragraph"
                , text [] "Another paragraph, this time a little bit longer to make sure, this line will be divided into at least two lines"
                ]
    in
        test "basic doc definition" <|
            isEqual (docDefinition pdf) result


result =
    """
    {
      content: [
        {
          text: 'First paragraph'
        },
        {
          text: 'Another paragraph, this time a little bit longer to make sure, this line will be divided into at least two lines'
        }
      ],
      defaultStyle: {},
      pageMargins: [
        72,
        72,
        72,
        72
      ],
      pageOrientation: 'portrait',
      pageSize: 'A4'
    }
    """
