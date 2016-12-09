module Main exposing (main)

import Html exposing (Html)
import Html.Attributes
import Html.Events


diagram =
    "elmview.png"


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { labels : List Label
    , newLabel : String
    }


model : Model
model =
    { labels = [ { text = "Main", x = 100, y = 200 } ]
    , newLabel = ""
    }



-- UPDATE


type Msg
    = Noop
    | NewLabel String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Noop ->
            model

        NewLabel string ->
            { model | newLabel = string }



-- VIEW


view : Model -> Html Msg
view model =
    Html.main_ []
        [ Html.canvas
            [ Html.Attributes.style
                [ ( "backgroundImage"
                  , "url(" ++ diagram ++ ")"
                  )
                ]
            ]
            []
        , drawLabels model.labels
        , newLabelInput model
        ]


type alias Label =
    { text : String, x : Int, y : Int }


drawLabels : List Label -> Html Msg
drawLabels labels =
    let
        oneLabel { text, x, y } =
            Html.label
                [ Html.Attributes.style
                    [ ( "position", "absolute" )
                    , ( "top", (toString y) ++ "px" )
                    , ( "left", (toString x) ++ "px" )
                    ]
                ]
                [ Html.text text ]
    in
        Html.div [] (List.map oneLabel labels)


newLabelInput : Model -> Html Msg
newLabelInput model =
    Html.input
        [ Html.Attributes.id "newLabel"
        , Html.Events.onInput NewLabel
        , Html.Attributes.value model.newLabel
        , Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "top", (toString 200) ++ "px" )
            , ( "left", (toString 100) ++ "px" )
            ]
        ]
        []
