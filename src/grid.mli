type 'a t

val empty : 'a t

val generate_randomly_filled_int_grid :
  int -> int -> int -> int -> int t
(** [randomly_filled_int_grid r c l u] is a grid with [r] rows and [c]
    columns with every element in it in between [l] and [u] inclusive. *)

val print_int_grid : int t -> unit
(** [print_int_grid g] prints the grid in a readable format. *)

val get : 'a t -> int -> int -> 'a
(** [get g r c] is the equivalent of [g\[r\]\[c\]] in Java. *)

val update_grid : 'a t -> int -> int -> 'a -> 'a t
(** [update_grid g r c e] is a new grid that is the same as [g] but with
    [e] located at row [r] column [c]. *)
