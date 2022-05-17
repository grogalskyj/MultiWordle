type t

val empty : t

val generate_randomly_filled_grid : int -> int -> int -> int -> t
(** [randomly_filled_grid r c l u] is a grid with [r] rows and [c]
    columns with every element in it in between [l] and [u] inclusive. *)

val print_grid : t -> unit
(** [print_grid g] prints the grid in a readable format*)