module Point = struct
  type elem = int
  type t = elem * elem
  let x (x', _) = x'
  let y (_, y') = y'
end

module Dimen = struct
  type elem = int
  type t = elem * elem
  let row (row', _) = row'
  let col (_, col') = col'
end
