type t = char array array

module List = ListLabels

let paint t = ()
let blank_char = '.'

let char_of_color = function
  | Actor.Red     -> '#'
  | Actor.Magenta -> '#'
  | Actor.Yellow  -> '#'
  | Actor.Cyan    -> '#'
  | Actor.Blue    -> '#'
  | Actor.Gray    -> '#'
  | Actor.Lime    -> '#'

let render state =
  let screen = Array.make_matrix 10 10 blank_char in

  List.iter (Game_state.blocks state) ~f:(fun (point, color) ->
    Geom.Point.(screen.(x point).(y point) <- char_of_color color));

  screen
