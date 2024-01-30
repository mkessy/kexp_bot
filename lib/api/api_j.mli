(* Auto-generated from "api.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

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

val write_show :
  Buffer.t -> show -> unit
  (** Output a JSON value of type {!type:show}. *)

val string_of_show :
  ?len:int -> show -> string
  (** Serialize a value of type {!type:show}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_show :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> show
  (** Input JSON data of type {!type:show}. *)

val show_of_string :
  string -> show
  (** Deserialize JSON data of type {!type:show}. *)

val write_shows_response :
  Buffer.t -> shows_response -> unit
  (** Output a JSON value of type {!type:shows_response}. *)

val string_of_shows_response :
  ?len:int -> shows_response -> string
  (** Serialize a value of type {!type:shows_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_shows_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> shows_response
  (** Input JSON data of type {!type:shows_response}. *)

val shows_response_of_string :
  string -> shows_response
  (** Deserialize JSON data of type {!type:shows_response}. *)

val write_program :
  Buffer.t -> program -> unit
  (** Output a JSON value of type {!type:program}. *)

val string_of_program :
  ?len:int -> program -> string
  (** Serialize a value of type {!type:program}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_program :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> program
  (** Input JSON data of type {!type:program}. *)

val program_of_string :
  string -> program
  (** Deserialize JSON data of type {!type:program}. *)

val write_program_response :
  Buffer.t -> program_response -> unit
  (** Output a JSON value of type {!type:program_response}. *)

val string_of_program_response :
  ?len:int -> program_response -> string
  (** Serialize a value of type {!type:program_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_program_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> program_response
  (** Input JSON data of type {!type:program_response}. *)

val program_response_of_string :
  string -> program_response
  (** Deserialize JSON data of type {!type:program_response}. *)

val write_play :
  Buffer.t -> play -> unit
  (** Output a JSON value of type {!type:play}. *)

val string_of_play :
  ?len:int -> play -> string
  (** Serialize a value of type {!type:play}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_play :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> play
  (** Input JSON data of type {!type:play}. *)

val play_of_string :
  string -> play
  (** Deserialize JSON data of type {!type:play}. *)

val write_plays_response :
  Buffer.t -> plays_response -> unit
  (** Output a JSON value of type {!type:plays_response}. *)

val string_of_plays_response :
  ?len:int -> plays_response -> string
  (** Serialize a value of type {!type:plays_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_plays_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> plays_response
  (** Input JSON data of type {!type:plays_response}. *)

val plays_response_of_string :
  string -> plays_response
  (** Deserialize JSON data of type {!type:plays_response}. *)

