module Styles exposing (..)

import Color exposing (Color)
import Color.Mixing
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onInput)
import Setup.Msg as Msg exposing (Msg)
import Setup.Settings as Settings
import Style exposing (..)
import Style.Background
import Style.Border as Border
import Style.Color as Color
import Style.Filter as Filter
import Style.Font as Font


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type Styles
    = None
    | Debug
    | Main
    | Logo
    | NavOption
    | WideButton
    | NavButton NavButtonType
    | Tooltip
    | Navbar
    | RosterTable
    | ShortcutInput
    | AThing
    | Input
    | KeyboardKey
    | RoleViewName
    | AwayIcon
    | TipBox
    | TipTitle
    | TipBody
    | TipLink
    | StepButton
    | RoseIcon
    | Circle CircleFill
    | Hairline
    | BreakButton
    | SkipBreakButton
    | BreakAlertBox


type NavButtonType
    = Danger
    | Warning


fonts : { title : List String, body : List String }
fonts =
    { title = [ "Anton", "helvetica", "arial", "sans-serif" ], body = [ "Open Sans Condensed", "Helvetica Neue", "helvetica", "arial", "sans-serif" ] }


responsiveForWidth : Device -> ( Float, Float ) -> Float
responsiveForWidth { width } something =
    responsive (toFloat width) ( 600, 4000 ) something


primaryColor : Color.Color
primaryColor =
    Color.white


type alias StyleProperty =
    Style.Property Styles Never


buttonGradient : Color.Mixing.Factor -> Color -> StyleProperty
buttonGradient factor color =
    Style.Background.gradient 30
        [ color |> Style.Background.step
        , color |> Color.Mixing.darken factor |> Style.Background.step
        ]


buttonGradients : Color.Mixing.Factor -> Color -> { main : StyleProperty, hover : StyleProperty }
buttonGradients factor color =
    { main = color |> buttonGradient factor
    , hover = color |> Color.Mixing.darken 0.04 |> buttonGradient factor
    }


type CircleFill
    = Filled
    | Hollow


circleColor : Color
circleColor =
    Color.rgb 0 140 255


stylesheet : Device -> StyleSheet Styles Never
stylesheet device =
    let
        responsiveForWidthWith =
            responsiveForWidth device

        mediumLargeFontSize =
            responsiveForWidthWith ( 25, 180 )

        mediumFontSize =
            responsiveForWidthWith ( 28, 65 )

        mediumSmallFontSize =
            responsiveForWidthWith ( 20, 60 )

        smallFontSize =
            responsiveForWidthWith ( 10, 45 )

        extraSmallFontSize =
            responsiveForWidthWith ( 8, 38 )

        tipFontColor =
            Color.rgb 35 35 35

        tipBoxColor =
            Color.rgb 160 160 160
    in
    Style.stylesheet
        [ style None []
        , style Debug [ Color.background (Color.rgb 74 242 161) ]
        , style Input
            [ Font.size mediumSmallFontSize
            ]
        , style Hairline
            [ Color.text (Color.rgba 55 55 55 60)
            , Border.all 1
            , Border.dashed
            ]
        , style ShortcutInput
            [ Font.uppercase
            ]
        , style (Circle Filled)
            [ Border.solid
            , Border.all 2
            , Color.background circleColor
            , Color.border circleColor
            , Border.rounded 50
            ]
        , style (Circle Hollow)
            [ Border.solid
            , Border.all 2
            , Border.rounded 50
            , Color.border circleColor
            ]
        , style TipBox
            [ Color.background tipBoxColor
            , Border.rounded 3
            , Border.solid
            , Border.all 2
            , Color.border (Color.rgb 20 20 20)
            ]
        , style TipTitle
            [ Font.size mediumSmallFontSize
            , Color.text tipFontColor
            , Font.typeface [ "Playfair Display", "serif" ]
            , Font.uppercase
            , Font.weight 900
            ]
        , style TipLink
            [ Font.typeface [ "Droid Serif", "serif" ]
            , Color.text tipFontColor
            , Font.size smallFontSize
            , Font.justify
            , Font.underline
            ]
        , style TipBody
            [ Font.typeface [ "Droid Serif", "serif" ]
            , Color.text tipFontColor
            , Font.size smallFontSize
            , Font.justify
            ]
        , style AwayIcon
            [ Color.text (Color.rgba 120 20 20 30)
            , Font.size extraSmallFontSize
            , Font.typeface fonts.body
            , Border.rounded 10
            , Color.background (Color.rgb 30 30 30)
            , Color.border (Color.rgba 100 100 100 25)
            , hover
                [ Color.text (Color.rgba 200 20 20 255)
                , Color.background (Color.rgb 70 70 70)
                ]
            ]
        , style StepButton
            [ Color.text <| Color.rgb 239 177 1
            , Color.background (Color.rgb 30 30 30)
            , Border.rounded 10
            , Font.size extraSmallFontSize
            , hover
                [ Color.background (Color.rgb 70 70 70)
                ]
            ]
        , style RoleViewName
            [ Font.size mediumLargeFontSize
            , Font.typeface fonts.body
            ]
        , style KeyboardKey
            [ Color.text Color.black
            , Style.Background.gradient -90 [ Style.Background.step <| Color.white, Style.Background.step <| Color.rgb 207 207 207 ]
            , Border.rounded 3
            , Font.lineHeight 2.5
            , Font.center
            , Border.solid
            , Border.all 1
            , Font.size smallFontSize
            , Color.border (Color.rgb 170 170 170)
            , Font.typeface [ "Consolas", "Lucida Console", "monospace" ]
            ]
        , style Main
            [ Color.text primaryColor
            , Color.background (Color.rgb 40 40 40)
            , Font.typeface fonts.body
            , Font.size 16
            , Font.lineHeight 1.3 -- line height, given as a ratio of current font size.
            ]
        , style Navbar
            [ Color.background Color.black
            ]
        , style RosterTable
            [ Color.background Color.green ]
        , style Logo
            [ Font.size mediumFontSize
            , Font.typeface fonts.title
            ]
        , style RoseIcon
            [ Style.filters
                [ Filter.brightness 90
                ]
            ]
        , style WideButton
            [ Font.size (responsiveForWidthWith ( 22, 155 ))
            , Border.none
            , Font.typeface fonts.title
            , Color.rgb 132 25 163 |> buttonGradients 0.14 |> .main
            , Color.text primaryColor
            , Border.rounded 10
            , Font.center
            , hover
                [ Color.rgb 132 25 163 |> buttonGradients 0.14 |> .hover
                ]
            ]
        , style SkipBreakButton
            [ Font.size (responsiveForWidthWith ( 16, 120 ))
            , Border.none
            , Font.typeface fonts.title
            , Color.rgb 186 186 186 |> buttonGradients 0.14 |> .main
            , Color.text primaryColor
            , Border.rounded 10
            , Font.center
            , hover
                [ Color.rgb 186 186 186 |> buttonGradients 0.14 |> .hover
                ]
            ]
        , style BreakButton
            [ Font.size (responsiveForWidthWith ( 16, 120 ))
            , Border.none
            , Font.typeface fonts.title
            , Color.rgb 8 226 108 |> buttonGradients 0.14 |> .main
            , Color.text primaryColor
            , Border.rounded 10
            , Font.center
            , hover
                [ Color.rgb 8 226 108 |> buttonGradients 0.14 |> .hover
                ]
            ]
        , style BreakAlertBox
            [ Border.none
            , Font.typeface fonts.body
            , Font.size smallFontSize
            , Color.background circleColor
            , Color.text primaryColor
            , Border.rounded 3
            , Font.center
            ]
        , style Tooltip
            [ Color.background (Color.rgb 201 201 201)
            , Font.size 28
            , opacity 0
            , Font.typeface fonts.body
            ]
        , style (NavButton Danger)
            [ Font.size extraSmallFontSize
            , Border.none
            , Color.text primaryColor
            , Color.rgb 194 12 12 |> buttonGradients 0.06 |> .main
            , Border.rounded 5
            , Font.center
            , hover
                [ Color.rgb 194 12 12 |> buttonGradients 0.06 |> .hover
                ]
            , Font.typeface fonts.body
            ]
        , style (NavButton Warning)
            [ Font.size extraSmallFontSize
            , Border.none
            , Color.text primaryColor
            , Color.rgb 239 177 1 |> buttonGradients 0.06 |> .main
            , Border.rounded 5
            , Font.center
            , hover
                [ Color.rgb 239 177 1 |> buttonGradients 0.06 |> .hover
                ]
            , Font.typeface fonts.body
            ]
        , style NavOption
            [ Font.size 12
            , Font.typeface fonts.body
            , Color.text (Color.rgb 255 179 116)
            ]
        ]


type alias StyleElement =
    Element Styles Never Msg


navbar : StyleElement
navbar =
    row Navbar
        [ justify, paddingXY 10 10, verticalCenter ]
        [ row None [ spacing 12 ] [ roseIcon, el Logo [] (text "Mobster") ]
        , row None
            [ spacing 20 ]
            [ Element.image "./assets/invisible.png" None [ width (px 40), height (px 40) ] Element.empty
            , navButtonView "Hide" Warning Msg.hide
            , navButtonView "Quit" Danger Msg.quit
            ]
        ]


navButtonView : String -> NavButtonType -> Msg -> StyleElement
navButtonView buttonText navButtonType msg =
    button <| el (NavButton navButtonType) [ minWidth <| px 60, height <| px 34, Element.Events.onClick msg ] (text buttonText)


inputPair : String -> String -> StyleElement
inputPair label value =
    row Input
        [ spacing 20 ]
        [ numberInput 5 ( 1, 10 )
        , el None [] <| text label
        ]


numberInput : Int -> ( Int, Int ) -> StyleElement
numberInput value ( minValue, maxValue ) =
    Element.node "input" <|
        el None
            [ width <| px 60
            , minValue |> toString |> Element.Attributes.min
            , maxValue |> toString |> Element.Attributes.max
            , Element.Attributes.step "1"
            , type_ "number"
            , value |> toString |> Element.Attributes.value
            ]
            empty


keyBase : StyleElement -> StyleElement
keyBase =
    el KeyboardKey [ minWidth (px 60), minHeight (px 40), padding 5 ]


keyboardKey : String -> StyleElement
keyboardKey key =
    keyBase <| text key


editableKeyboardKey : String -> StyleElement
editableKeyboardKey currentKey =
    keyBase <|
        Element.inputText ShortcutInput
            [ width (px 30)
            , center
            , verticalCenter
            , inlineStyle [ "text-align" => "center" ]
            , onInput (Msg.ChangeInput (Msg.StringField Msg.ShowHideShortcut))
            ]
            currentKey


configOptions : Settings.Data -> StyleElement
configOptions settings =
    Element.column None
        [ Element.Attributes.spacing 30 ]
        [ column None
            [ spacing 10 ]
            [ inputPair "Minutes" "5"
            , inputPair "Break every 25'" "5"
            , inputPair "Minutes per break" "5"
            ]
        , column None [ spacing 8 ] [ text "Show/Hide Shortcut", row None [ spacing 10 ] [ keyboardKey "⌘", keyboardKey "Shift", editableKeyboardKey settings.showHideShortcut ] ]
        ]


startMobbingButton : String -> StyleElement
startMobbingButton title =
    column None
        [ class "setupTooltipContainer" ]
        [ (button <| el WideButton [ padding 13, Element.Events.onClick Msg.StartTimer, Element.Attributes.id "continue-button" ] (text title))
            |> above [ el Tooltip [ center, width (px 200), class "setupTooltip" ] (text "This is a tooltip") ]
        ]


roseIcon : StyleElement
roseIcon =
    Element.image "./assets/rose.png" None [ height (px 40), width (px 25) ] Element.empty