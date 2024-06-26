open Tyxml.Html

let head_section =
  let open Tyxml in
  [%html
    {|
    <head>
        <title>My Application</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>
        <script src="https://unpkg.com/htmx.org@1.9.11"></script>
        <script src="https://unpkg.com/hyperscript.org@0.9.12"></script>
        
    </head>
|}]
;;

let y = Tyxml.Html.Unsafe.leaf "sl-card" ~a:[ a_class [ "card-basic" ] ] ()

let custom_element =
  div ~a:[ a_class [ "flex flex-col h-full justify-center items-center" ] ] [ y ]
;;

let centered_layout content =
  div
    ~a:
      [ a_class
          [ "flex flex-col min-h-screen justify-center items-center bg-gray-900 \
             text-white"
          ]
      ]
    [ content ]
;;

let main_layout content =
  div
    ~a:
      [ a_class
          [ "dark"
          ; "flex"
          ; "flex-col"
          ; "h-screen"
          ; "justify-center"
          ; "items-center"
          ; "bg-gray-900"
          ; "text-white"
          ]
      ]
    content
;;

let search_layout content =
  div
    ~a:
      [ a_class
          [ "flex"
          ; "flex-col"
          ; "min-h-screen"
          ; "justify-center"
          ; "items-center"
          ; "bg-gray-900"
          ; "text-white"
          ; "p-4"
          ]
      ]
    content
;;

let base ~(history : Controller.Types.play_song list) ~body_content =
  let open Tyxml.Html in
  let open Components in
  let live_play_bar =
    let now_playing = List.hd history in
    let history = List.tl history in
    LivePlayBar.render ~now_playing ~history
  in
  html head_section (body [ live_play_bar; body_content ])
;;
