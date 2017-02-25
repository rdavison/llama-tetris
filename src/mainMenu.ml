open! Import

type link =
  | Start
  | Exit

type t = {
  cursor: link
}

let link_order = [
  Start ;
  Exit ;
]

let string_of_link = function
  | Start -> "Start"
  | Exit -> "Exit"

let create () = {
  cursor = Start
}

let follow_link x = ()
(* let follow_link = function *)
(*   | Start -> *)
(*     let state = Game_state.create () in *)
(*     Game_state.run state *)
(*   | Exit -> *)
(*     exit 0 *)

let next_link ?order from =
  let rec aux = function
    | [] -> from
    | x :: xs ->
      if x = from then
        match xs with
        | y :: ys -> y
        | [] -> x
      else
        aux xs
  in
  match order with
  | Some links -> aux links
  | None -> aux link_order

let prev_link =
  let rev = List.rev link_order in
  fun from ->
    next_link ?order:(Some rev) from

let handle ev = ()
