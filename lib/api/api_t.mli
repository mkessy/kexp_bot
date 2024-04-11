(* Auto-generated from "api.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type usage = { input_tokens: int; output_tokens: int }

type t = Yojson.Safe.t

type tool = { name: string; description: string option; input_schema: t }

type thumbnail = {
  two_fifty: string option;
  five_hundred: string option;
  twelve_hundred: string option;
  small: string option;
  large: string option
}

type text_content_block = { type_: string; text: string }

type stop_reason = [ `EndTurn | `MaxTokens | `StopSequence ]

type show = {
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

type shows_response = {
  next: string option;
  previous: string option;
  results: show list
}

type role = [ `User | `Assistant ]

type content_block = text_content_block

type response = {
  id: string;
  type_: string;
  role: role;
  content: content_block list;
  model: string;
  stop_reason: stop_reason;
  stop_sequence: string option;
  usage: usage
}

type metadata = {
  stop_sequences: string list option;
  stream: bool option;
  system: string option;
  temperature: float option;
  tools: tool option list;
  top_k: int option;
  top_p: float option
}

type message = { role: role; content: string }

type request_message = {
  model: string;
  messages: message list;
  max_tokens: int;
  metadata: metadata option
}

type image = {
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

type release_group_response = { release: string; images: image list }

type program = {
  id: int;
  uri: string;
  name: string;
  tags: string;
  description: string;
  is_active: bool
}

type program_response = {
  next: string option;
  previous: string option;
  results: program list
}

type play = {
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

type plays_response = {
  next: string option;
  previous: string option;
  results: play list
}
