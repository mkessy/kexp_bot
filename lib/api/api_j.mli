(* Auto-generated from "api.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type usage = Api_t.usage = { input_tokens: int; output_tokens: int }

type t = Yojson.Safe.t

type tool = Api_t.tool = {
  name: string;
  description: string option;
  input_schema: t
}

type thumbnail = Api_t.thumbnail = {
  two_fifty: string option;
  five_hundred: string option;
  twelve_hundred: string option;
  small: string option;
  large: string option
}

type text_content_block = Api_t.text_content_block = {
  type_: string;
  text: string
}

type stop_reason = Api_t.stop_reason

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

type role = Api_t.role

type content_block = Api_t.content_block

type response = Api_t.response = {
  id: string;
  type_: string;
  role: role;
  content: content_block list;
  model: string;
  stop_reason: stop_reason;
  stop_sequence: string option;
  usage: usage
}

type metadata = Api_t.metadata = {
  stop_sequences: string list option;
  stream: bool option;
  system: string option;
  temperature: float option;
  tools: tool option list;
  top_k: int option;
  top_p: float option
}

type message = Api_t.message = { role: role; content: string }

type request_message = Api_t.request_message = {
  model: string;
  messages: message list;
  max_tokens: int;
  metadata: metadata option
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

val write_usage :
  Buffer.t -> usage -> unit
  (** Output a JSON value of type {!type:usage}. *)

val string_of_usage :
  ?len:int -> usage -> string
  (** Serialize a value of type {!type:usage}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_usage :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> usage
  (** Input JSON data of type {!type:usage}. *)

val usage_of_string :
  string -> usage
  (** Deserialize JSON data of type {!type:usage}. *)

val write_t :
  Buffer.t -> t -> unit
  (** Output a JSON value of type {!type:t}. *)

val string_of_t :
  ?len:int -> t -> string
  (** Serialize a value of type {!type:t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> t
  (** Input JSON data of type {!type:t}. *)

val t_of_string :
  string -> t
  (** Deserialize JSON data of type {!type:t}. *)

val write_tool :
  Buffer.t -> tool -> unit
  (** Output a JSON value of type {!type:tool}. *)

val string_of_tool :
  ?len:int -> tool -> string
  (** Serialize a value of type {!type:tool}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_tool :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> tool
  (** Input JSON data of type {!type:tool}. *)

val tool_of_string :
  string -> tool
  (** Deserialize JSON data of type {!type:tool}. *)

val write_thumbnail :
  Buffer.t -> thumbnail -> unit
  (** Output a JSON value of type {!type:thumbnail}. *)

val string_of_thumbnail :
  ?len:int -> thumbnail -> string
  (** Serialize a value of type {!type:thumbnail}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_thumbnail :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> thumbnail
  (** Input JSON data of type {!type:thumbnail}. *)

val thumbnail_of_string :
  string -> thumbnail
  (** Deserialize JSON data of type {!type:thumbnail}. *)

val write_text_content_block :
  Buffer.t -> text_content_block -> unit
  (** Output a JSON value of type {!type:text_content_block}. *)

val string_of_text_content_block :
  ?len:int -> text_content_block -> string
  (** Serialize a value of type {!type:text_content_block}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_text_content_block :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> text_content_block
  (** Input JSON data of type {!type:text_content_block}. *)

val text_content_block_of_string :
  string -> text_content_block
  (** Deserialize JSON data of type {!type:text_content_block}. *)

val write_stop_reason :
  Buffer.t -> stop_reason -> unit
  (** Output a JSON value of type {!type:stop_reason}. *)

val string_of_stop_reason :
  ?len:int -> stop_reason -> string
  (** Serialize a value of type {!type:stop_reason}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_stop_reason :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> stop_reason
  (** Input JSON data of type {!type:stop_reason}. *)

val stop_reason_of_string :
  string -> stop_reason
  (** Deserialize JSON data of type {!type:stop_reason}. *)

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

val write_role :
  Buffer.t -> role -> unit
  (** Output a JSON value of type {!type:role}. *)

val string_of_role :
  ?len:int -> role -> string
  (** Serialize a value of type {!type:role}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_role :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> role
  (** Input JSON data of type {!type:role}. *)

val role_of_string :
  string -> role
  (** Deserialize JSON data of type {!type:role}. *)

val write_content_block :
  Buffer.t -> content_block -> unit
  (** Output a JSON value of type {!type:content_block}. *)

val string_of_content_block :
  ?len:int -> content_block -> string
  (** Serialize a value of type {!type:content_block}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_content_block :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> content_block
  (** Input JSON data of type {!type:content_block}. *)

val content_block_of_string :
  string -> content_block
  (** Deserialize JSON data of type {!type:content_block}. *)

val write_response :
  Buffer.t -> response -> unit
  (** Output a JSON value of type {!type:response}. *)

val string_of_response :
  ?len:int -> response -> string
  (** Serialize a value of type {!type:response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> response
  (** Input JSON data of type {!type:response}. *)

val response_of_string :
  string -> response
  (** Deserialize JSON data of type {!type:response}. *)

val write_metadata :
  Buffer.t -> metadata -> unit
  (** Output a JSON value of type {!type:metadata}. *)

val string_of_metadata :
  ?len:int -> metadata -> string
  (** Serialize a value of type {!type:metadata}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metadata :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metadata
  (** Input JSON data of type {!type:metadata}. *)

val metadata_of_string :
  string -> metadata
  (** Deserialize JSON data of type {!type:metadata}. *)

val write_message :
  Buffer.t -> message -> unit
  (** Output a JSON value of type {!type:message}. *)

val string_of_message :
  ?len:int -> message -> string
  (** Serialize a value of type {!type:message}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_message :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> message
  (** Input JSON data of type {!type:message}. *)

val message_of_string :
  string -> message
  (** Deserialize JSON data of type {!type:message}. *)

val write_request_message :
  Buffer.t -> request_message -> unit
  (** Output a JSON value of type {!type:request_message}. *)

val string_of_request_message :
  ?len:int -> request_message -> string
  (** Serialize a value of type {!type:request_message}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_request_message :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> request_message
  (** Input JSON data of type {!type:request_message}. *)

val request_message_of_string :
  string -> request_message
  (** Deserialize JSON data of type {!type:request_message}. *)

val write_image :
  Buffer.t -> image -> unit
  (** Output a JSON value of type {!type:image}. *)

val string_of_image :
  ?len:int -> image -> string
  (** Serialize a value of type {!type:image}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_image :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> image
  (** Input JSON data of type {!type:image}. *)

val image_of_string :
  string -> image
  (** Deserialize JSON data of type {!type:image}. *)

val write_release_group_response :
  Buffer.t -> release_group_response -> unit
  (** Output a JSON value of type {!type:release_group_response}. *)

val string_of_release_group_response :
  ?len:int -> release_group_response -> string
  (** Serialize a value of type {!type:release_group_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_release_group_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> release_group_response
  (** Input JSON data of type {!type:release_group_response}. *)

val release_group_response_of_string :
  string -> release_group_response
  (** Deserialize JSON data of type {!type:release_group_response}. *)

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

