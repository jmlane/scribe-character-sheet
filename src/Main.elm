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
    , soak : Int
    , woundsThreshold : Int
    , woundsCurrent : Int
    , strainThreshold : Int
    , strainCurrent : Int
    , defenseRanged : Int
    , defenseMelee : Int
    , characteristics : Characteristics
    }


type alias Characteristics =
    { brawn : Int
    , agility : Int
    , intellect : Int
    , cunning : Int
    , willpower : Int
    , presence : Int
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
    ( Model "" Nothing "" "" 0 0 0 0 0 0 0 (Characteristics 0 0 0 0 0 0)
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
        , viewDerivedAttributes model
        , viewCharacteristics model.characteristics
        ]


labelledInput : String -> String -> Html Msg
labelledInput label_ value_ =
    label []
        [ text label_
        , input [ value value_ ] []
        ]


viewCharacterInfo : Model -> Html Msg
viewCharacterInfo model =
    let
        archetypeString : Maybe Archetype -> String
        archetypeString maybe =
            case maybe of
                Just archetype ->
                    toString archetype

                Nothing ->
                    ""
    in
    section []
        [ h2 [] [ text "Character" ]
        , labelledInput "Character Name:" model.name
        , labelledInput "Species/Archetypes:" (archetypeString model.archetype)
        , labelledInput "Career:" model.career
        , labelledInput "Player:" model.player
        ]


viewDerivedAttributes : Model -> Html Msg
viewDerivedAttributes model =
    section []
        [ h2 [] [ text "Derived Attributes" ]
        , labelledInput "Soak Value" (String.fromInt model.soak)
        , labelledInput "Wound Threshold" (String.fromInt model.woundsThreshold)
        , labelledInput "Current Wounds" (String.fromInt model.woundsCurrent)
        , labelledInput "Strain Threshold" (String.fromInt model.strainThreshold)
        , labelledInput "Current Strain" (String.fromInt model.strainCurrent)
        , labelledInput "Ranged Defense" (String.fromInt model.defenseRanged)
        , labelledInput "Melee Defense" (String.fromInt model.defenseMelee)
        ]


viewCharacteristics : Characteristics -> Html Msg
viewCharacteristics characteristics =
    section []
        [ h2 [] [ text "Characteristics" ]
        , labelledInput "Brawn" (String.fromInt characteristics.brawn)
        , labelledInput "Agility" (String.fromInt characteristics.agility)
        , labelledInput "Intellect" (String.fromInt characteristics.intellect)
        , labelledInput "Cunning" (String.fromInt characteristics.cunning)
        , labelledInput "Willpower" (String.fromInt characteristics.willpower)
        , labelledInput "Presence" (String.fromInt characteristics.presence)
        ]
