type t = int list list

let empty = []

let generate_random_int (lower_bound : int) (upper_bound : int) : int =
  let _ = Random.self_init () in
  lower_bound + Random.int (upper_bound - lower_bound + 1)

let rec generate_randomly_filled_list
    (length : int)
    (lower_bound : int)
    (upper_bound : int) : int list =
  if length = 0 then []
  else
    generate_random_int lower_bound upper_bound
    :: generate_randomly_filled_list (length - 1) lower_bound
         upper_bound

let rec generate_randomly_filled_grid
    (rows : int)
    (columns : int)
    (lower_bound : int)
    (upper_bound : int) : t =
  if rows = 0 then []
  else
    generate_randomly_filled_list columns lower_bound upper_bound
    :: generate_randomly_filled_grid (rows - 1) columns lower_bound
         upper_bound

let rec print_list (list : int list) =
  match list with
  | [] -> print_string "\n\n\n"
  | [ h ] ->
      print_string (string_of_int h);
      print_list []
  | h :: t ->
      print_string (string_of_int h ^ "   ");
      print_list t

let rec print_grid (grid : t) =
  match grid with
  | [] -> print_string "\n"
  | h :: t ->
      print_list h;
      print_grid t
