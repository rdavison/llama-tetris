open! Import
open LTerm
open Lwt.Infix

type block = Geom.Point.t * Actor.color

let cfg_poll_event_timeout = 0.01

type t = {
  ticks         : int;
  level         : int;
  lines_cleared : int;
  actor         : Actor.t option;
  blocks        : block list;
  windows       : Window.t list;
  exit          : bool;
}

let create () = {
  ticks         = 0;
  level         = 1;
  lines_cleared = 0;
  actor         = None;
  blocks        = [];
  windows       = [];
  exit          = false;
}

let push_win t ~window = 
  { t with windows = window :: t.windows }

let pop_win t =
  match t.windows with
  | x :: xs -> Some x, { t with windows = xs }
  | []      -> None  , t

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

let slurp_events term =
  let rec aux acc =
    poll_event term >>= function
    | Some ev -> aux (ev :: acc)
    | None -> Lwt.return (List.rev acc)
  in
  aux []

let next state event =
  let exit = Option.is_some event in
  Lwt.return
    { state with
      ticks = state.ticks + 1;
      exit  = exit }

let run state ~term =
  slurp_events term >>= function
  | [] -> next state None
  | ev -> List.fold_left ev ~init:(Lwt.return state) ~f:(fun acc x ->
     acc >>= (fun state -> next state (Some x)))
