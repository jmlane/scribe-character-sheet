module Main exposing (main)

import Browser exposing (document)
import Html exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = "Laura Sauer"
      , player = "Jon"
      , classes = [ ( "Paladin", 7 ) ]
      , race = "Human"
      , attributes = Attributes 18 12 14 8 8 18
      , inspiration = False
      , skills = []
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODELS


type Msg
    = NoOp


type alias Model =
    { name : String
    , player : String
    , classes : List ( String, Int )
    , race : String
    , attributes : Attributes
    , inspiration : Bool
    , skills : Skills
    }



-- hp (total, current, temp) note: what's derived vs provided
-- hit dice
-- attacks/spells


type alias Attributes =
    { strength : Int
    , dexterity : Int
    , constitution : Int
    , intelligence : Int
    , wisdom : Int
    , charisma : Int
    }


type alias Skills =
    List String



-- VIEWS


view : Model -> Html Msg
view model =
    let
        subheader : String
        subheader =
            model.race ++ " " ++ characterLevels

        characterLevels : String
        characterLevels =
            model.classes
                |> List.map
                    (\( class, level ) ->
                        "Level " ++ String.fromInt level ++ " " ++ class
                    )
                |> String.join ", "

        inspiration : String
        inspiration =
            if model.inspiration then
                "true"

            else
                "false"
    in
    section []
        [ h1 []
            [ text model.name
            , br [] []
            , text subheader
            ]
        , p [] [ text ("Player: " ++ model.player) ]
        , p [] [ text ("Race: " ++ model.race) ]
        , p []
            [ text ("Inspiration: " ++ inspiration) ]
        , viewAttributes model.attributes
        , viewSkills model.skills
        ]


viewAttributes : Attributes -> Html Msg
viewAttributes attributes =
    let
        mapToHtmlLi : ( String, Int ) -> Html Msg
        mapToHtmlLi ( attribute, value ) =
            li [] [ text <| attribute ++ ": " ++ String.fromInt value ]
    in
    section []
        [ h2 [] [ text "Attributes" ]
        , ul [] <|
            List.map mapToHtmlLi <|
                [ ( "Strength", attributes.strength )
                , ( "Dexterity", attributes.dexterity )
                , ( "Constitution", attributes.constitution )
                , ( "Intelligence", attributes.intelligence )
                , ( "Wisdom", attributes.wisdom )
                , ( "Charisma", attributes.charisma )
                ]
        ]


viewSkills : Skills -> Html Msg
viewSkills skills =
    let
        mapfunc : String -> Html Msg
        mapfunc name =
            li [] [ text name ]
    in
    section []
        [ h2 [] [ text "Skills" ]
        , ul [] <|
            List.map mapfunc <|
                [ "Athletics"
                , "Acrobatics"
                , "Sleight of Hand"
                , "Stealth"
                , "Arcana"
                , "History"
                , "Investigation"
                , "Nature"
                , "Religion"
                , "Animal Handling"
                , "Insight"
                , "Medicine"
                , "Perception"
                , "Survival"
                , "Deception"
                , "Intimidation"
                , "Performance"
                , "Persuasion"
                ]
        ]
