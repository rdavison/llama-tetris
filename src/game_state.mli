type block = Geom.Point.t * Actor.color
type t

val create : unit -> t
val next : t -> term:LTerm.t -> t option Lwt.t
val blocks : t -> block list
