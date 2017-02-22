type shape = I | J | L | O | S | T | Z

type color =
  | Red
  | Magenta
  | Yellow
  | Cyan
  | Blue
  | Gray
  | Lime

let color_of_shape = function
  | I -> Red
  | J -> Magenta
  | L -> Yellow
  | O -> Cyan
  | S -> Blue
  | T -> Gray
  | Z -> Lime

type t = {
  shape: shape;
  color: color;
}

let next () =
  let shape = I in {
    shape = shape;
    color = color_of_shape shape;
  }

let rot90 t = t
let rot180 t = t
