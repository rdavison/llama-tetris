type t

val paint : t -> unit
val render : Game_state.t -> t
val char_of_color : Actor.color -> char
