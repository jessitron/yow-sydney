module Main exposing (main)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode


diagram =
    "elmprogram.png"


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { labels : List Label
    , newLabel : String
    }


init : ( Model, Cmd Msg )
init =
    { labels = []
    , newLabel = ""
    }
        ! []



-- UPDATE


type Msg
    = Noop
    | NewLabel String
    | SaveLabel Label


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            model ! []

        NewLabel string ->
            { model | newLabel = string } ! []

        SaveLabel label ->
            { model
                | labels = label :: model.labels
                , newLabel = ""
            }
                ! []



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
        , onEnter (SaveLabel { text = model.newLabel, x = 100, y = 200 })
        , Html.Attributes.value model.newLabel
        , Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "top", (toString 200) ++ "px" )
            , ( "left", (toString 100) ++ "px" )
            ]
        ]
        []


onEnter : Msg -> Html.Attribute Msg
onEnter msg =
    let
        tagger code =
            if code == 13 then
                msg
            else
                Noop
    in
        Html.Events.on "keydown" (Json.Decode.map tagger Html.Events.keyCode)



-- SUBSCRIPTIONS


subscriptions model =
    Sub.none
