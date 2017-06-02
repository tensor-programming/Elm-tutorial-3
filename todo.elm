module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }

--model



type alias Model =
    { todo : String
    , todos : List String
    }

model : Model
model =
    { todo = ""
    , todos = []
    }




--update



type Msg
    = UpdateTodo String
    | AddTodo
    | RemoveItem String
    | RemoveAll
    | ClearInput


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTodo text ->
            { model | todo = text }

        AddTodo ->
            { model | todos = model.todo :: model.todos }

        RemoveItem text ->
            { model | todos = List.filter (\x -> x /= text) model.todos }

        RemoveAll ->
            { model | todos = [] }

        ClearInput ->
            { model | todo = "" }



--view


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "Rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
            ]

        children =
            []
    in
        node tag attrs children


todoItem : String -> Html Msg
todoItem todo =
    li [ class "list-group-item" ] [ text todo, button [ onClick (RemoveItem todo), class "btn btn-info" ] [ text "x" ] ]


todoList : List String -> Html Msg
todoList todos =
    let
        child =
            List.map todoItem todos
    in
        ul [ class "list-group" ] child


view : Model -> Html Msg
view model =
    div [ class "jumbotron" ]
        [ stylesheet
        , input
            [ type_ "text"
            , onInput UpdateTodo
            , class "form-control"
            , value model.todo
            , onMouseEnter ClearInput
            ]
            []
        , button [ onClick AddTodo, class "btn btn-primary" ] [ text "Submit" ]
        , button [ onClick RemoveAll, class "btn btn-danger" ] [ text "Remove All" ]
        , todoList model.todos
        ]
