type t

val create : Geom.Dimen.t -> t
val apply : t -> Actor.t -> Geom.Point.t -> unit
