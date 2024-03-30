(* Auto-generated from "api.atd" *)
[@@@ocaml.warning "-27-32-33-35-39"]

type thumbnail = {
  two_fifty: string option;
  five_hundred: string option;
  twelve_hundred: string option;
  small: string option;
  large: string option
}

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
