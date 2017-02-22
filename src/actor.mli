type shape
type color =
  | Red
  | Magenta
  | Yellow
  | Cyan
  | Blue
  | Gray
  | Lime

val color_of_shape : shape -> color

type t

val next : unit -> t
val rot90 : t -> t
val rot180 : t -> t
