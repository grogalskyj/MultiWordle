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

let rec get_filtered_words (dic : string list) : string =
  (*ensure word returned is less than length 8s*)
  let proposed_word = choose_random_word dic in
  if String.length proposed_word < 5 then proposed_word
  else get_filtered_words dic

let generate_hidden_words (size : int) (dic : string list) : string list
    =
  let return_list = [] in
  if List.length return_list = size then return_list
  else get_filtered_words dic :: return_list

let make_hidden_words (size : string) (dic : string list) : string list
    =
  match size with
  | "small" -> generate_hidden_words 4 dic
  | "medium" -> generate_hidden_words 8 dic
  | "large" -> generate_hidden_words 12 dic
  | _ -> failwith "not possible"

let reverse_index (i : int) : char = Char.chr i
let character = reverse_index (97 + Random.int 25)

let rec add_char_array (board_size : int) (return_array : char list) =
  if List.length return_array = board_size then return_array
<<<<<<< HEAD
  else character :: add_char_array board_size return_array

let rec fill_in_board (board_size : int) (return_array : char list list)
    : char list list =
  if List.length return_array = board_size then return_array
  else
    add_char_array board_size []
    :: fill_in_board board_size return_array

let make_game_board (hidden_words : string list) : char list list =
  match List.length hidden_words with
  | 4 -> fill_in_board 10 []
  | 5 -> fill_in_board 10 []
  | 6 -> fill_in_board 10 []
  | 7 -> fill_in_board 10 []
  | 8 -> fill_in_board 15 []
  | 9 -> fill_in_board 15 []
  | 10 -> fill_in_board 15 []
  | 11 -> fill_in_board 15 []
  | 12 -> fill_in_board 20 []
  | 13 -> fill_in_board 20 []
  | 14 -> fill_in_board 20 []
  | 15 -> fill_in_board 20 []
  | _ -> failwith "to many words :0"
=======
  else character :: return_array
(* let fill_in_board (board_size : int): char list list = let
   return_array = [add_char_array] in if List.length return_array =
   board_size then

   let make_game_board (hidden_words : string list) : char list list =
   match List.length hidden_words with | 4 -> fill_in_board 10 *)
>>>>>>> 87f8336ded1eee3e2df3030f2746abbabecb48df
