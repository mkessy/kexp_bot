(* Auto-generated from "api.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type thumbnail = Api_t.thumbnail = {
  two_fifty: string option;
  five_hundred: string option;
  twelve_hundred: string option;
  small: string option;
  large: string option
}

type show = Api_t.show = {
  id: int;
  uri: string;
  program: int;
  program_uri: string;
  hosts: int list;
  host_uris: string list;
  program_name: string;
  program_tags: string;
  host_names: string list;
  tagline: string;
  image_uri: string;
  start_time: string
}

type shows_response = Api_t.shows_response = {
  next: string option;
  previous: string option;
  results: show list
}

type image = Api_t.image = {
  edit: int;
  id: int;
  image: string;
  thumbnails: thumbnail;
  comment: string;
  approved: bool;
  front: bool;
  types: string list;
  back: bool
}

type release_group_response = Api_t.release_group_response = {
  release: string;
  images: image list
}

type program = Api_t.program = {
  id: int;
  uri: string;
  name: string;
  tags: string;
  description: string;
  is_active: bool
}

type program_response = Api_t.program_response = {
  next: string option;
  previous: string option;
  results: program list
}

type play = Api_t.play = {
  id: int;
  uri: string;
  airdate: string;
  show: int;
  play_type: string;
  show_uri: string;
  image_uri: string option;
  thumbnail_uri: string option;
  comment: string option;
  song: string option;
  track_id: string option;
  recording_id: string option;
  artist: string option;
  artist_ids: string list option;
  album: string option;
  released_id: string option;
  release_group_id: string option;
  labels: string list option;
  label_ids: string list option;
  release_date: string option;
  rotation_status: string option;
  is_local: bool option;
  is_request: bool option;
  is_live: bool option
}

type plays_response = Api_t.plays_response = {
  next: string option;
  previous: string option;
  results: play list
}

let write__string_option = (
  Atdgen_runtime.Oj_run.write_option (
    Yojson.Safe.write_string
  )
)
let string_of__string_option ?(len = 1024) x =
  let ob = Buffer.create len in
  write__string_option ob x;
  Buffer.contents ob
let read__string_option = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          match Yojson.Safe.read_ident p lb with
            | "None" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | "Some" ->
              Atdgen_runtime.Oj_run.read_until_field_value p lb;
              let x = (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Double_quote -> (
          match Yojson.Safe.finish_string p lb with
            | "None" ->
              (None : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Square_bracket -> (
          match Atdgen_runtime.Oj_run.read_string p lb with
            | "Some" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
)
let _string_option_of_string s =
  read__string_option (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_thumbnail : _ -> thumbnail -> _ = (
  fun ob (x : thumbnail) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    (match x.two_fifty with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"250\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.five_hundred with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"500\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.twelve_hundred with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"1200\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.small with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"small\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.large with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"large\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    Buffer.add_char ob '}';
)
let string_of_thumbnail ?(len = 1024) x =
  let ob = Buffer.create len in
  write_thumbnail ob x;
  Buffer.contents ob
let read_thumbnail = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_two_fifty = ref (None) in
    let field_five_hundred = ref (None) in
    let field_twelve_hundred = ref (None) in
    let field_small = ref (None) in
    let field_large = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 3 -> (
                match String.unsafe_get s pos with
                  | '2' -> (
                      if String.unsafe_get s (pos+1) = '5' && String.unsafe_get s (pos+2) = '0' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | '5' -> (
                      if String.unsafe_get s (pos+1) = '0' && String.unsafe_get s (pos+2) = '0' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 4 -> (
                if String.unsafe_get s pos = '1' && String.unsafe_get s (pos+1) = '2' && String.unsafe_get s (pos+2) = '0' && String.unsafe_get s (pos+3) = '0' then (
                  2
                )
                else (
                  -1
                )
              )
            | 5 -> (
                match String.unsafe_get s pos with
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'l' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_two_fifty := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_five_hundred := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 2 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_twelve_hundred := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 3 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_small := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 4 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_large := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 3 -> (
                  match String.unsafe_get s pos with
                    | '2' -> (
                        if String.unsafe_get s (pos+1) = '5' && String.unsafe_get s (pos+2) = '0' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | '5' -> (
                        if String.unsafe_get s (pos+1) = '0' && String.unsafe_get s (pos+2) = '0' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 4 -> (
                  if String.unsafe_get s pos = '1' && String.unsafe_get s (pos+1) = '2' && String.unsafe_get s (pos+2) = '0' && String.unsafe_get s (pos+3) = '0' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'l' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_two_fifty := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_five_hundred := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 2 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_twelve_hundred := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 3 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_small := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 4 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_large := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            two_fifty = !field_two_fifty;
            five_hundred = !field_five_hundred;
            twelve_hundred = !field_twelve_hundred;
            small = !field_small;
            large = !field_large;
          }
         : thumbnail)
      )
)
let thumbnail_of_string s =
  read_thumbnail (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__string_list = (
  Atdgen_runtime.Oj_run.write_list (
    Yojson.Safe.write_string
  )
)
let string_of__string_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__string_list ob x;
  Buffer.contents ob
let read__string_list = (
  Atdgen_runtime.Oj_run.read_list (
    Atdgen_runtime.Oj_run.read_string
  )
)
let _string_list_of_string s =
  read__string_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__int_list = (
  Atdgen_runtime.Oj_run.write_list (
    Yojson.Safe.write_int
  )
)
let string_of__int_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__int_list ob x;
  Buffer.contents ob
let read__int_list = (
  Atdgen_runtime.Oj_run.read_list (
    Atdgen_runtime.Oj_run.read_int
  )
)
let _int_list_of_string s =
  read__int_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_show : _ -> show -> _ = (
  fun ob (x : show) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.uri;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"program\":";
    (
      Yojson.Safe.write_int
    )
      ob x.program;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"program_uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.program_uri;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"hosts\":";
    (
      write__int_list
    )
      ob x.hosts;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"host_uris\":";
    (
      write__string_list
    )
      ob x.host_uris;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"program_name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.program_name;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"program_tags\":";
    (
      Yojson.Safe.write_string
    )
      ob x.program_tags;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"host_names\":";
    (
      write__string_list
    )
      ob x.host_names;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"tagline\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tagline;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"image_uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.image_uri;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"start_time\":";
    (
      Yojson.Safe.write_string
    )
      ob x.start_time;
    Buffer.add_char ob '}';
)
let string_of_show ?(len = 1024) x =
  let ob = Buffer.create len in
  write_show ob x;
  Buffer.contents ob
let read_show = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (None) in
    let field_uri = ref (None) in
    let field_program = ref (None) in
    let field_program_uri = ref (None) in
    let field_hosts = ref (None) in
    let field_host_uris = ref (None) in
    let field_program_name = ref (None) in
    let field_program_tags = ref (None) in
    let field_host_names = ref (None) in
    let field_tagline = ref (None) in
    let field_image_uri = ref (None) in
    let field_start_time = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 3 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                  1
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' then (
                  4
                )
                else (
                  -1
                )
              )
            | 7 -> (
                match String.unsafe_get s pos with
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'e' then (
                        9
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'h' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 's' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' then (
                        10
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'h' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'e' then (
                        11
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'i' then (
                  3
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' then (
                  match String.unsafe_get s (pos+8) with
                    | 'n' -> (
                        if String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'm' && String.unsafe_get s (pos+11) = 'e' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 's' then (
                          7
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 1 ->
            field_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 2 ->
            field_program := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 3 ->
            field_program_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 4 ->
            field_hosts := (
              Some (
                (
                  read__int_list
                ) p lb
              )
            );
          | 5 ->
            field_host_uris := (
              Some (
                (
                  read__string_list
                ) p lb
              )
            );
          | 6 ->
            field_program_name := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 7 ->
            field_program_tags := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 8 ->
            field_host_names := (
              Some (
                (
                  read__string_list
                ) p lb
              )
            );
          | 9 ->
            field_tagline := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 10 ->
            field_image_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 11 ->
            field_start_time := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 3 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  match String.unsafe_get s pos with
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'e' then (
                          9
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'h' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 's' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' then (
                          10
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'h' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'e' then (
                          11
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'i' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' then (
                    match String.unsafe_get s (pos+8) with
                      | 'n' -> (
                          if String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'm' && String.unsafe_get s (pos+11) = 'e' then (
                            6
                          )
                          else (
                            -1
                          )
                        )
                      | 't' -> (
                          if String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 's' then (
                            7
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 1 ->
              field_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 2 ->
              field_program := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 3 ->
              field_program_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 4 ->
              field_hosts := (
                Some (
                  (
                    read__int_list
                  ) p lb
                )
              );
            | 5 ->
              field_host_uris := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            | 6 ->
              field_program_name := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 7 ->
              field_program_tags := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 8 ->
              field_host_names := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            | 9 ->
              field_tagline := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 10 ->
              field_image_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 11 ->
              field_start_time := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            id = (match !field_id with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "id");
            uri = (match !field_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "uri");
            program = (match !field_program with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "program");
            program_uri = (match !field_program_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "program_uri");
            hosts = (match !field_hosts with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "hosts");
            host_uris = (match !field_host_uris with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "host_uris");
            program_name = (match !field_program_name with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "program_name");
            program_tags = (match !field_program_tags with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "program_tags");
            host_names = (match !field_host_names with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "host_names");
            tagline = (match !field_tagline with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "tagline");
            image_uri = (match !field_image_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "image_uri");
            start_time = (match !field_start_time with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "start_time");
          }
         : show)
      )
)
let show_of_string s =
  read_show (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__show_list = (
  Atdgen_runtime.Oj_run.write_list (
    write_show
  )
)
let string_of__show_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__show_list ob x;
  Buffer.contents ob
let read__show_list = (
  Atdgen_runtime.Oj_run.read_list (
    read_show
  )
)
let _show_list_of_string s =
  read__show_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_shows_response : _ -> shows_response -> _ = (
  fun ob (x : shows_response) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    (match x.next with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"next\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.previous with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"previous\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"results\":";
    (
      write__show_list
    )
      ob x.results;
    Buffer.add_char ob '}';
)
let string_of_shows_response ?(len = 1024) x =
  let ob = Buffer.create len in
  write_shows_response ob x;
  Buffer.contents ob
let read_shows_response = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_next = ref (None) in
    let field_previous = ref (None) in
    let field_results = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_next := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_previous := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 2 ->
            field_results := (
              Some (
                (
                  read__show_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_next := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_previous := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 2 ->
              field_results := (
                Some (
                  (
                    read__show_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            next = !field_next;
            previous = !field_previous;
            results = (match !field_results with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "results");
          }
         : shows_response)
      )
)
let shows_response_of_string s =
  read_shows_response (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_image : _ -> image -> _ = (
  fun ob (x : image) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"edit\":";
    (
      Yojson.Safe.write_int
    )
      ob x.edit;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"image\":";
    (
      Yojson.Safe.write_string
    )
      ob x.image;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"thumbnails\":";
    (
      write_thumbnail
    )
      ob x.thumbnails;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"comment\":";
    (
      Yojson.Safe.write_string
    )
      ob x.comment;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"approved\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.approved;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"front\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.front;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"types\":";
    (
      write__string_list
    )
      ob x.types;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"back\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.back;
    Buffer.add_char ob '}';
)
let string_of_image ?(len = 1024) x =
  let ob = Buffer.create len in
  write_image ob x;
  Buffer.contents ob
let read_image = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_edit = ref (None) in
    let field_id = ref (None) in
    let field_image = ref (None) in
    let field_thumbnails = ref (None) in
    let field_comment = ref (None) in
    let field_approved = ref (None) in
    let field_front = ref (None) in
    let field_types = ref (None) in
    let field_back = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  1
                )
                else (
                  -1
                )
              )
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'k' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 't' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 5 -> (
                match String.unsafe_get s pos with
                  | 'f' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' then (
                        7
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                  4
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'p' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' then (
                  5
                )
                else (
                  -1
                )
              )
            | 10 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 's' then (
                  3
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_edit := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 1 ->
            field_id := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 2 ->
            field_image := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 3 ->
            field_thumbnails := (
              Some (
                (
                  read_thumbnail
                ) p lb
              )
            );
          | 4 ->
            field_comment := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 5 ->
            field_approved := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              )
            );
          | 6 ->
            field_front := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              )
            );
          | 7 ->
            field_types := (
              Some (
                (
                  read__string_list
                ) p lb
              )
            );
          | 8 ->
            field_back := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'k' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 't' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 'f' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' then (
                          7
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'p' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 's' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_edit := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 1 ->
              field_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 2 ->
              field_image := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 3 ->
              field_thumbnails := (
                Some (
                  (
                    read_thumbnail
                  ) p lb
                )
              );
            | 4 ->
              field_comment := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 5 ->
              field_approved := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            | 6 ->
              field_front := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            | 7 ->
              field_types := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            | 8 ->
              field_back := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            edit = (match !field_edit with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "edit");
            id = (match !field_id with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "id");
            image = (match !field_image with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "image");
            thumbnails = (match !field_thumbnails with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "thumbnails");
            comment = (match !field_comment with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "comment");
            approved = (match !field_approved with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "approved");
            front = (match !field_front with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "front");
            types = (match !field_types with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "types");
            back = (match !field_back with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "back");
          }
         : image)
      )
)
let image_of_string s =
  read_image (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__image_list = (
  Atdgen_runtime.Oj_run.write_list (
    write_image
  )
)
let string_of__image_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__image_list ob x;
  Buffer.contents ob
let read__image_list = (
  Atdgen_runtime.Oj_run.read_list (
    read_image
  )
)
let _image_list_of_string s =
  read__image_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_release_group_response : _ -> release_group_response -> _ = (
  fun ob (x : release_group_response) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"release\":";
    (
      Yojson.Safe.write_string
    )
      ob x.release;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"images\":";
    (
      write__image_list
    )
      ob x.images;
    Buffer.add_char ob '}';
)
let string_of_release_group_response ?(len = 1024) x =
  let ob = Buffer.create len in
  write_release_group_response ob x;
  Buffer.contents ob
let read_release_group_response = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_release = ref (None) in
    let field_images = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 6 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_release := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 1 ->
            field_images := (
              Some (
                (
                  read__image_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 6 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_release := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 1 ->
              field_images := (
                Some (
                  (
                    read__image_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            release = (match !field_release with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "release");
            images = (match !field_images with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "images");
          }
         : release_group_response)
      )
)
let release_group_response_of_string s =
  read_release_group_response (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_program : _ -> program -> _ = (
  fun ob (x : program) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.uri;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.name;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"tags\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tags;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"description\":";
    (
      Yojson.Safe.write_string
    )
      ob x.description;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"is_active\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.is_active;
    Buffer.add_char ob '}';
)
let string_of_program ?(len = 1024) x =
  let ob = Buffer.create len in
  write_program ob x;
  Buffer.contents ob
let read_program = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (None) in
    let field_uri = ref (None) in
    let field_name = ref (None) in
    let field_tags = ref (None) in
    let field_description = ref (None) in
    let field_is_active = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 3 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                  1
                )
                else (
                  -1
                )
              )
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 's' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'v' && String.unsafe_get s (pos+8) = 'e' then (
                  5
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' then (
                  4
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 1 ->
            field_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 2 ->
            field_name := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 3 ->
            field_tags := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 4 ->
            field_description := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 5 ->
            field_is_active := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 3 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 's' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'v' && String.unsafe_get s (pos+8) = 'e' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 1 ->
              field_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 2 ->
              field_name := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 3 ->
              field_tags := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 4 ->
              field_description := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 5 ->
              field_is_active := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            id = (match !field_id with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "id");
            uri = (match !field_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "uri");
            name = (match !field_name with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "name");
            tags = (match !field_tags with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "tags");
            description = (match !field_description with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "description");
            is_active = (match !field_is_active with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "is_active");
          }
         : program)
      )
)
let program_of_string s =
  read_program (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__program_list = (
  Atdgen_runtime.Oj_run.write_list (
    write_program
  )
)
let string_of__program_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__program_list ob x;
  Buffer.contents ob
let read__program_list = (
  Atdgen_runtime.Oj_run.read_list (
    read_program
  )
)
let _program_list_of_string s =
  read__program_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_program_response : _ -> program_response -> _ = (
  fun ob (x : program_response) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    (match x.next with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"next\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.previous with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"previous\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"results\":";
    (
      write__program_list
    )
      ob x.results;
    Buffer.add_char ob '}';
)
let string_of_program_response ?(len = 1024) x =
  let ob = Buffer.create len in
  write_program_response ob x;
  Buffer.contents ob
let read_program_response = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_next = ref (None) in
    let field_previous = ref (None) in
    let field_results = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_next := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_previous := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 2 ->
            field_results := (
              Some (
                (
                  read__program_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_next := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_previous := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 2 ->
              field_results := (
                Some (
                  (
                    read__program_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            next = !field_next;
            previous = !field_previous;
            results = (match !field_results with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "results");
          }
         : program_response)
      )
)
let program_response_of_string s =
  read_program_response (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__string_list_option = (
  Atdgen_runtime.Oj_run.write_option (
    write__string_list
  )
)
let string_of__string_list_option ?(len = 1024) x =
  let ob = Buffer.create len in
  write__string_list_option ob x;
  Buffer.contents ob
let read__string_list_option = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          match Yojson.Safe.read_ident p lb with
            | "None" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | "Some" ->
              Atdgen_runtime.Oj_run.read_until_field_value p lb;
              let x = (
                  read__string_list
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Double_quote -> (
          match Yojson.Safe.finish_string p lb with
            | "None" ->
              (None : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Square_bracket -> (
          match Atdgen_runtime.Oj_run.read_string p lb with
            | "Some" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read__string_list
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
)
let _string_list_option_of_string s =
  read__string_list_option (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__bool_option = (
  Atdgen_runtime.Oj_run.write_option (
    Yojson.Safe.write_bool
  )
)
let string_of__bool_option ?(len = 1024) x =
  let ob = Buffer.create len in
  write__bool_option ob x;
  Buffer.contents ob
let read__bool_option = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          match Yojson.Safe.read_ident p lb with
            | "None" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | "Some" ->
              Atdgen_runtime.Oj_run.read_until_field_value p lb;
              let x = (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Double_quote -> (
          match Yojson.Safe.finish_string p lb with
            | "None" ->
              (None : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
      | `Square_bracket -> (
          match Atdgen_runtime.Oj_run.read_string p lb with
            | "Some" ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Atdgen_runtime.Oj_run.read_bool
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | x ->
              Atdgen_runtime.Oj_run.invalid_variant_tag p x
        )
)
let _bool_option_of_string s =
  read__bool_option (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_play : _ -> play -> _ = (
  fun ob (x : play) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.uri;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"airdate\":";
    (
      Yojson.Safe.write_string
    )
      ob x.airdate;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"show\":";
    (
      Yojson.Safe.write_int
    )
      ob x.show;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"play_type\":";
    (
      Yojson.Safe.write_string
    )
      ob x.play_type;
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"show_uri\":";
    (
      Yojson.Safe.write_string
    )
      ob x.show_uri;
    (match x.image_uri with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"image_uri\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.thumbnail_uri with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"thumbnail_uri\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.comment with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"comment\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.song with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"song\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.track_id with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"track_id\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.recording_id with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"recording_id\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.artist with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"artist\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.artist_ids with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"artist_ids\":";
      (
        write__string_list
      )
        ob x;
    );
    (match x.album with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"album\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.released_id with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"released_id\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.release_group_id with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"release_group_id\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.labels with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"labels\":";
      (
        write__string_list
      )
        ob x;
    );
    (match x.label_ids with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"label_ids\":";
      (
        write__string_list
      )
        ob x;
    );
    (match x.release_date with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"release_date\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.rotation_status with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"rotation_status\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.is_local with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"is_local\":";
      (
        Yojson.Safe.write_bool
      )
        ob x;
    );
    (match x.is_request with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"is_request\":";
      (
        Yojson.Safe.write_bool
      )
        ob x;
    );
    (match x.is_live with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"is_live\":";
      (
        Yojson.Safe.write_bool
      )
        ob x;
    );
    Buffer.add_char ob '}';
)
let string_of_play ?(len = 1024) x =
  let ob = Buffer.create len in
  write_play ob x;
  Buffer.contents ob
let read_play = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (None) in
    let field_uri = ref (None) in
    let field_airdate = ref (None) in
    let field_show = ref (None) in
    let field_play_type = ref (None) in
    let field_show_uri = ref (None) in
    let field_image_uri = ref (None) in
    let field_thumbnail_uri = ref (None) in
    let field_comment = ref (None) in
    let field_song = ref (None) in
    let field_track_id = ref (None) in
    let field_recording_id = ref (None) in
    let field_artist = ref (None) in
    let field_artist_ids = ref (None) in
    let field_album = ref (None) in
    let field_released_id = ref (None) in
    let field_release_group_id = ref (None) in
    let field_labels = ref (None) in
    let field_label_ids = ref (None) in
    let field_release_date = ref (None) in
    let field_rotation_status = ref (None) in
    let field_is_local = ref (None) in
    let field_is_request = ref (None) in
    let field_is_live = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 3 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                  1
                )
                else (
                  -1
                )
              )
            | 4 -> (
                if String.unsafe_get s pos = 's' then (
                  match String.unsafe_get s (pos+1) with
                    | 'h' -> (
                        if String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'w' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 'o' -> (
                        if String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'g' then (
                          9
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'm' then (
                  14
                )
                else (
                  -1
                )
              )
            | 6 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' then (
                        12
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 's' then (
                        17
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 7 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' then (
                        23
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'l' then (
                        21
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'w' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'i' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' then (
                        10
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 's' then (
                        18
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'y' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'e' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 's' then (
                        13
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'q' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 't' then (
                        22
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'd' then (
                  15
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' then (
                  match String.unsafe_get s (pos+2) with
                    | 'c' -> (
                        if String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'd' then (
                          11
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' then (
                          19
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'i' then (
                  7
                )
                else (
                  -1
                )
              )
            | 15 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 's' then (
                  20
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'd' then (
                  16
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 1 ->
            field_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 2 ->
            field_airdate := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 3 ->
            field_show := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_int
                ) p lb
              )
            );
          | 4 ->
            field_play_type := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 5 ->
            field_show_uri := (
              Some (
                (
                  Atdgen_runtime.Oj_run.read_string
                ) p lb
              )
            );
          | 6 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_image_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 7 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_thumbnail_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 8 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_comment := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 9 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_song := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 10 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_track_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 11 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_recording_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 12 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_artist := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 13 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_artist_ids := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            )
          | 14 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_album := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 15 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_released_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 16 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_release_group_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 17 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_labels := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            )
          | 18 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_label_ids := (
                Some (
                  (
                    read__string_list
                  ) p lb
                )
              );
            )
          | 19 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_release_date := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 20 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_rotation_status := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 21 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_is_local := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            )
          | 22 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_is_request := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            )
          | 23 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_is_live := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_bool
                  ) p lb
                )
              );
            )
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 3 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  if String.unsafe_get s pos = 's' then (
                    match String.unsafe_get s (pos+1) with
                      | 'h' -> (
                          if String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'w' then (
                            3
                          )
                          else (
                            -1
                          )
                        )
                      | 'o' -> (
                          if String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'g' then (
                            9
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'm' then (
                    14
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' then (
                          12
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 's' then (
                          17
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 7 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' then (
                          23
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'l' then (
                          21
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'w' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'i' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' then (
                          10
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 's' then (
                          18
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'y' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'e' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 's' then (
                          13
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'q' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 't' then (
                          22
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'd' then (
                    15
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' then (
                    match String.unsafe_get s (pos+2) with
                      | 'c' -> (
                          if String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'd' then (
                            11
                          )
                          else (
                            -1
                          )
                        )
                      | 'l' -> (
                          if String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' then (
                            19
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'i' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 15 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 's' then (
                    20
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'd' then (
                    16
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 1 ->
              field_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 2 ->
              field_airdate := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 3 ->
              field_show := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_int
                  ) p lb
                )
              );
            | 4 ->
              field_play_type := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 5 ->
              field_show_uri := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            | 6 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_image_uri := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 7 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_thumbnail_uri := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 8 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_comment := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 9 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_song := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 10 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_track_id := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 11 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_recording_id := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 12 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_artist := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 13 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_artist_ids := (
                  Some (
                    (
                      read__string_list
                    ) p lb
                  )
                );
              )
            | 14 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_album := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 15 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_released_id := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 16 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_release_group_id := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 17 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_labels := (
                  Some (
                    (
                      read__string_list
                    ) p lb
                  )
                );
              )
            | 18 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_label_ids := (
                  Some (
                    (
                      read__string_list
                    ) p lb
                  )
                );
              )
            | 19 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_release_date := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 20 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_rotation_status := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 21 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_is_local := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_bool
                    ) p lb
                  )
                );
              )
            | 22 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_is_request := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_bool
                    ) p lb
                  )
                );
              )
            | 23 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_is_live := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_bool
                    ) p lb
                  )
                );
              )
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            id = (match !field_id with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "id");
            uri = (match !field_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "uri");
            airdate = (match !field_airdate with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "airdate");
            show = (match !field_show with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "show");
            play_type = (match !field_play_type with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "play_type");
            show_uri = (match !field_show_uri with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "show_uri");
            image_uri = !field_image_uri;
            thumbnail_uri = !field_thumbnail_uri;
            comment = !field_comment;
            song = !field_song;
            track_id = !field_track_id;
            recording_id = !field_recording_id;
            artist = !field_artist;
            artist_ids = !field_artist_ids;
            album = !field_album;
            released_id = !field_released_id;
            release_group_id = !field_release_group_id;
            labels = !field_labels;
            label_ids = !field_label_ids;
            release_date = !field_release_date;
            rotation_status = !field_rotation_status;
            is_local = !field_is_local;
            is_request = !field_is_request;
            is_live = !field_is_live;
          }
         : play)
      )
)
let play_of_string s =
  read_play (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__play_list = (
  Atdgen_runtime.Oj_run.write_list (
    write_play
  )
)
let string_of__play_list ?(len = 1024) x =
  let ob = Buffer.create len in
  write__play_list ob x;
  Buffer.contents ob
let read__play_list = (
  Atdgen_runtime.Oj_run.read_list (
    read_play
  )
)
let _play_list_of_string s =
  read__play_list (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_plays_response : _ -> plays_response -> _ = (
  fun ob (x : plays_response) ->
    Buffer.add_char ob '{';
    let is_first = ref true in
    (match x.next with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"next\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.previous with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Buffer.add_char ob ',';
        Buffer.add_string ob "\"previous\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    if !is_first then
      is_first := false
    else
      Buffer.add_char ob ',';
      Buffer.add_string ob "\"results\":";
    (
      write__play_list
    )
      ob x.results;
    Buffer.add_char ob '}';
)
let string_of_plays_response ?(len = 1024) x =
  let ob = Buffer.create len in
  write_plays_response ob x;
  Buffer.contents ob
let read_plays_response = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_next = ref (None) in
    let field_previous = ref (None) in
    let field_results = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_next := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_previous := (
                Some (
                  (
                    Atdgen_runtime.Oj_run.read_string
                  ) p lb
                )
              );
            )
          | 2 ->
            field_results := (
              Some (
                (
                  read__play_list
                ) p lb
              )
            );
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg (Printf.sprintf "out-of-bounds substring position or length: string = %S, requested position = %i, requested length = %i" s pos len);
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Atdgen_runtime.Oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_next := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_previous := (
                  Some (
                    (
                      Atdgen_runtime.Oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 2 ->
              field_results := (
                Some (
                  (
                    read__play_list
                  ) p lb
                )
              );
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            next = !field_next;
            previous = !field_previous;
            results = (match !field_results with Some x -> x | None -> Atdgen_runtime.Oj_run.missing_field p "results");
          }
         : plays_response)
      )
)
let plays_response_of_string s =
  read_plays_response (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
