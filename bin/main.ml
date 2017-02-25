open Lwt
open LTerm_event

open Llama_tetris

let () = Printexc.record_backtrace true

let rec loop state term = 
  Game_state.run state ~term >>= function
  | { exit = true} -> return (print_endline "exiting")
  | next_state ->
    begin
      print_endline "continue";
      loop next_state term
    end

let main () =
  Lwt_io.printl "press any key to exit" >>= fun () ->
  Lazy.force LTerm.stdout >>= fun term ->
  LTerm.enable_mouse term >>= fun () ->
  LTerm.enter_raw_mode term >>= fun mode ->
  Lwt.finalize
    (fun () ->
      let state = Game_state.create () in
      loop state term)
    (fun () ->
      LTerm.leave_raw_mode term mode >>= fun () ->
      LTerm.disable_mouse term)


let () = Lwt_main.run (main ())
