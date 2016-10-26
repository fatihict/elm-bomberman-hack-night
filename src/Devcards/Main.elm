module Devcards.Main exposing (..)

-- import AnimationFrame

import Html exposing (Html, div)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, inMilliseconds)


type Orientation
    = Left
    | Right
    | Top
    | Bottom


orientationToFolder : Orientation -> String
orientationToFolder orientation =
    case orientation of
        Left ->
            "side"

        Right ->
            "side"

        Top ->
            "back"

        Bottom ->
            "front"


type alias Model =
    { step : Float
    , orientation : Orientation
    }


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { step = 0
      , orientation = Top
      }
    , Cmd.none
    )


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            let
                step =
                    model.step

                newStep =
                    if step == 7 then
                        0
                    else
                        step + 1
            in
                ( { model | step = newStep }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (inMilliseconds 66) Tick



{-
   type alias Model =
       { isWalking : Bool
       , orientation : Orientation
       }


   type Orientation
       = Left
       | Right
       | Top
       | Bottom

-}


view : Model -> Html Msg
view model =
    let
        t =
            case model.orientation of
                Left ->
                    "translate(54, 0) scale(-1, 1) "

                _ ->
                    ""
    in
        div []
            [ svg
                [ width "500px", height "500px" ]
                [ image
                    [ xlinkHref ("/src/assets/sprites/bomberman/" ++ (orientationToFolder model.orientation) ++ "/0" ++ (toString model.step) ++ ".png")
                    , transform t
                      --, Svg.Attributes.style "transform: scaleX(-1);"
                    , x "0"
                    , y "0"
                    , width "54px"
                    , height "128px"
                    ]
                    []
                ]
            ]
