type t = char array array

module List = ListLabels

let paint t = ()
let blank_char = '.'

let char_of_color = function
  | Actor.Red     -> 'R'
  | Actor.Magenta -> 'M'
  | Actor.Yellow  -> 'Y'
  | Actor.Cyan    -> 'C'
  | Actor.Blue    -> 'B'
  | Actor.Gray    -> 'G'
  | Actor.Lime    -> 'L'

let render (state : Game_state.t) =
  let screen = Array.make_matrix 10 10 blank_char in

  List.iter state.blocks ~f:(fun (point, color) ->
    Geom.Point.(screen.(x point).(y point) <- char_of_color color));

  screen
