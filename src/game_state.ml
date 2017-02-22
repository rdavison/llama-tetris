open LTerm
open Lwt.Infix

type block = Geom.Point.t * Actor.color

let cfg_poll_event_timeout = 0.01

type t = {
  level         : int;
  lines_cleared : int;
  actor         : Actor.t option;
  blocks        : block list;
}

let create () = {
  level         = 1;
  lines_cleared = 0;
  actor         = None;
  blocks        = [];
}

let slurp_events term =
  (* TODO: Potentially inefficient *)
  let rec loop acc =
    let success () =
      Lwt_unix.with_timeout cfg_poll_event_timeout
      (fun () -> LTerm.read_event term) >>= fun x ->
      loop (x :: acc)
    in
    let failure = function
      | Lwt_unix.Timeout -> Lwt.return acc
      | exn -> Lwt.fail exn
    in
    Lwt.catch success failure
  in
  loop []

let poll_event term =
  let success () =
    Lwt_unix.with_timeout cfg_poll_event_timeout
    (fun () -> LTerm.read_event term) >>= fun x ->
    Lwt.return (Some x)
  in
  let failure = function
    | Lwt_unix.Timeout -> Lwt.return None
    | exn -> Lwt.fail exn
  in
  Lwt.catch success failure

let next state ~term =
  slurp_events term >>= function
  | [] ->
    Lwt.return (Some state)
  | x :: xs ->
    Lwt.return None

let blocks { blocks } = blocks
