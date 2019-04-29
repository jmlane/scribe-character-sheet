module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { name : String
    , archetype : Maybe Archetype
    , career : String
    , player : String
    }


type Archetype
    = AverageHuman
    | Laborer
    | Intellectual
    | Aristocrat


toString : Archetype -> String
toString archetype =
    case archetype of
        AverageHuman ->
            "Average Human"

        Laborer ->
            "Laborer"

        Intellectual ->
            "Intellectual"

        Aristocrat ->
            "Aristocrat"


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" Nothing "" ""
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewCharacterInfo model
        ]


viewCharacterInfo : Model -> Html Msg
viewCharacterInfo model =
    let
        labelledInput : String -> String -> Html Msg
        labelledInput label_ value_ =
            label []
                [ text label_
                , input [ value value_ ] []
                ]

        archetypeString : Maybe Archetype -> String
        archetypeString maybe =
            case maybe of
                Just archetype ->
                    toString archetype

                Nothing ->
                    ""
    in
    div []
        [ h2 [] [ text "Character" ]
        , div []
            [ labelledInput "Character Name:" model.name
            , labelledInput "Species/Archetypes:" (archetypeString model.archetype)
            , labelledInput "Career:" model.career
            , labelledInput "Player:" model.player
            ]
        ]
