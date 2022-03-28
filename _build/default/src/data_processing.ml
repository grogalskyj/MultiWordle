let check_start_game (user_input : char) : bool =
  if user_input = 's' then true else false

let rec make_dic (dic : (string * Yojson.Basic.t) list) : string list =
  match dic with
  | [] -> []
  | (name, _) :: t -> name :: make_dic t

let rec generate_word_bank (num_letters : int) (dic : string list) :
    string list =
  match dic with
  | [] -> []
  | h :: t ->
      if String.length h = num_letters then
        h :: generate_word_bank num_letters t
      else generate_word_bank num_letters t

let choose_random_word (dic : string list) : string =
  let _ = Random.self_init () in
  List.nth dic (Random.int (List.length dic))

let is_word (word : string) (dic : string list) : bool =
  List.mem word dic
