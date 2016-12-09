module Main exposing (main)

import Html


diagram =
    "elmview.png"


main =
    Html.main_ []
        [ Html.canvas
            [ Html.Attributes.style
                [ ( "backgroundImage", "url(" + diagram + ")" )
                ]
            ]
            []
        ]
