open Tyxml.Html

let head =
  let open Tyxml in
  [%html
    {|
    <head>
        <title>My Application</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.12.0/cdn/themes/dark.css" />
        <script type="module" src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.12.0/cdn/shoelace-autoloader.js"></script>
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

let base body_content = html head (body body_content)
