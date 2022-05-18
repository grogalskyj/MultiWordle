open Player

type player_database = (string * player) list

let init_database = []

let update_database username player database =
  (username, player) :: database

let rec get_usernames (database : player_database) : string list =
  match database with
  | [] -> []
  | [ (h, _) ] -> [ h ]
  | (h, _) :: t -> h :: get_usernames t

let get_game_history (player_record : player) : (int * int) list =
  player_record.game_history

let rec get_guesses (history : (int * int) list) : int list =
  match history with
  | [] -> []
  | [ (_, guess) ] -> [ guess ]
  | (_, guess) :: t -> guess :: get_guesses t

let get_player_record (username : string) (database : player_database) :
    player =
  let usernames_list = get_usernames database in
  if List.mem username usernames_list then List.assoc username database
  else failwith "Player does not exist"

let games_played (username : string) (database : player_database) : int
    =
  let player_record = get_player_record username database in
  List.length player_record.game_history

let rec list_sum lst =
  match lst with
  | [] -> 0
  | [ h ] -> h
  | h :: t -> h + list_sum t

let last_three lst =
  match lst with
  | [] -> []
  | [ h ] -> [ h ]
  | [ h; t ] -> [ h; t ]
  | h :: m :: t :: _ -> [ h; m; t ]

let average_guesses (guesses : int list) : int =
  if List.length guesses <> 0 then
    let sum = list_sum guesses in
    sum / List.length guesses
  else 0

let get_average_guesses (player_record : player) : int =
  get_game_history player_record |> get_guesses |> average_guesses

let guess_trend (guesses : int list) : int =
  guesses |> last_three |> average_guesses

let get_guess_trend (player : player) : int =
  player |> get_game_history |> get_guesses |> last_three
  |> average_guesses

let rec guesses_summary_list
    (history : (int * int) list)
    (initial_list : (int * int) list) : (int * int) list =
  match history with
  | [] -> []
  | [ (_, t) ] ->
      if List.mem_assoc t initial_list then
        let prev_count = List.assoc t initial_list in
        (t, prev_count + 1) :: List.remove_assoc t initial_list
      else (t, 1) :: initial_list
  | (_, m) :: t ->
      if List.mem_assoc m initial_list then
        let new_list =
          let prev_count = List.assoc m initial_list in
          (m, prev_count + 1) :: List.remove_assoc m initial_list
        in
        guesses_summary_list t new_list
      else guesses_summary_list t initial_list

let rec assoc_list_value_max
    (assoc_list : (int * int) list)
    (current_max : int) : int =
  match assoc_list with
  | [] -> if current_max >= 1 then current_max else 1
  | [ (_, t) ] -> if current_max >= t then current_max else t
  | (_, m) :: t ->
      if current_max >= m then assoc_list_value_max t current_max
      else assoc_list_value_max t m

let rec scaled_guesses
    (guess_summary : (int * int) list)
    (final_list : (int * int) list)
    (max : int) : (int * int) list =
  match guess_summary with
  | [] -> []
  | [ (num_guesses, count) ] ->
      let scaled_count = count / max * 10 in
      (num_guesses, scaled_count) :: final_list
  | (num_guesses, count) :: t ->
      (num_guesses, count / max * 10) :: scaled_guesses final_list t max

let rec xstring_maker
    (repeats : int)
    (initial_string : string)
    (guess_value : int) : string =
  if repeats > 0 then
    xstring_maker (repeats - 1) (initial_string ^ "x") guess_value
  else initial_string ^ string_of_int guess_value

let summary_graph_maker (user : player) : unit =
  let guess_sum_list =
    user |> get_game_history |> guesses_summary_list []
  in
  let maximum = assoc_list_value_max guess_sum_list 1 in
  let scaled_guesses_list = scaled_guesses guess_sum_list [] maximum in
  print_endline
    (xstring_maker
       (List.assoc 1 scaled_guesses_list)
       ""
       (List.assoc 1 scaled_guesses_list));
  print_endline
    (xstring_maker
       (List.assoc 2 scaled_guesses_list)
       ""
       (List.assoc 2 scaled_guesses_list));
  print_endline
    (xstring_maker
       (List.assoc 3 scaled_guesses_list)
       ""
       (List.assoc 3 scaled_guesses_list));
  print_endline
    (xstring_maker
       (List.assoc 4 scaled_guesses_list)
       ""
       (List.assoc 4 scaled_guesses_list));
  print_endline
    (xstring_maker
       (List.assoc 5 scaled_guesses_list)
       ""
       (List.assoc 5 scaled_guesses_list));
  print_endline
    (xstring_maker
       (List.assoc 6 scaled_guesses_list)
       ""
       (List.assoc 6 scaled_guesses_list))
