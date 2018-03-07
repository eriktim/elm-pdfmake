module Internal.Object exposing (Value, arg, string, int, float, list, object, bool, function, const, stringify)

import Dict exposing (Dict)


type Value
    = ObjectValue (Dict String Value)
    | ArrayValue (List Value)
    | StringValue String
    | IntValue Int
    | FloatValue Float
    | BoolValue Bool


string : String -> Value
string =
    StringValue


int : Int -> Value
int =
    IntValue


float : Float -> Value
float =
    FloatValue


bool : Bool -> Value
bool =
    BoolValue


list : List Value -> Value
list =
    ArrayValue


object : List ( String, Value ) -> Value
object =
    ObjectValue << Dict.fromList



-- TODO arg/function/const


arg : String -> Value
arg str =
    -- TODO typed args
    StringValue str


function : List String -> String -> Value
function args body =
    StringValue <| "(" ++ String.join "," args ++ ") => {" ++ body ++ "}"


const : Value -> Value
const value =
    StringValue <| "() => " ++ stringify value


stringify : Value -> String
stringify =
    stringify_ 0



-- INTERNAL


{-| TODO cleanup
-}
stringify_ : Int -> Value -> String
stringify_ indent value =
    case value of
        ObjectValue dict ->
            if Dict.isEmpty dict then
                "{}"
            else
                let
                    space =
                        String.repeat indent " "

                    space2 =
                        String.repeat (indent + 2) " "

                    tuples =
                        List.map (\( k, v ) -> k ++ ": " ++ stringify_ (indent + 2) v) <| Dict.toList dict
                in
                    "{" ++ newLine ++ space2 ++ String.join ("," ++ newLine ++ space2) tuples ++ newLine ++ space ++ "}"

        ArrayValue items ->
            if List.isEmpty items then
                "[]"
            else
                let
                    space =
                        String.repeat indent " "

                    space2 =
                        String.repeat (indent + 2) " "
                in
                    "[" ++ newLine ++ space2 ++ String.join ("," ++ newLine ++ space2) (List.map (stringify_ <| indent + 2) items) ++ newLine ++ space ++ "]"

        StringValue value ->
            "'" ++ value ++ "'"

        IntValue value ->
            toString value

        FloatValue value ->
            toString value

        BoolValue value ->
            case value of
                True ->
                    "true"

                False ->
                    "false"


newLine : String
newLine =
    String.fromChar '\n'
