module Option = struct
  type 'a t = 'a option

  let map t ~f =
    match t with
    | Some x -> Some (f x)
    | None -> None

  let is_some = function
    | Some _ -> true
    | None -> false

  let is_none x = not (is_some x)
end

module List = ListLabels
