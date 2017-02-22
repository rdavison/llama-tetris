module Dimen : sig
  type elem = int
  type t = elem * elem
  val row : t -> elem
  val col : t -> elem
end

module Point : sig
  type elem = int
  type t = elem * elem
  val x : t -> elem
  val y : t -> elem
end
