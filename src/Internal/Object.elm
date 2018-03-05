module Internal.Object exposing (Value, arg, string, number, list, object, bool, function, const, stringify)


type Value
    = Value String


string : String -> Value
string str =
    Value <| "'" ++ str ++ "'"


arg : String -> Value
arg str = -- TODO typed args
    Value str


number : number -> Value
number =
    Value << toString


bool : Bool -> Value
bool bool_ =
    Value <|
        case bool_ of
            True ->
                "true"

            False ->
                "false"


list : List Value -> Value
list items =
    let
        items_ =
            List.map stringify items
    in
        Value <| "[" ++ String.join "," items_ ++ "]"


object : List ( String, Value ) -> Value
object items =
    let
        tuples =
            List.map (\( k, v ) -> k ++ ": " ++ stringify v) items
    in
        Value <| "{" ++ String.join "," tuples ++ "}"


function : List String -> String -> Value
function args body =
    Value <| "(" ++ String.join "," args ++ ") => {" ++ body ++ "}"


const : Value -> Value
const value =
    Value <| "() => " ++ stringify value

stringify : Value -> String
stringify value =
    case value of
        Value str ->
            str
