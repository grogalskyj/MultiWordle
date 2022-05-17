(* check_start_game (user_input : char) : bool = true if ‘s’ has been
   entered, false otherwise

   generate_word_bank (input_json : Yojson.Basic.t) (num_letters : int)
   : string list = generates a list of English words that are of length
   num_letters Link to English Dict. JSON
   https://gist.github.com/BideoWego/60fbd40d5d1f0f1beca11ba95221dd38

   choose_random_word (word_bank : string list) : string = generates a
   random word from the given word bank *)

val check_start_game : char -> bool
(** [check_start_game c] is true if the user has input the letter 's'
    and thus wants to start playing. It is false for any other input. *)

val make_dic : (string * Yojson.Basic.t) list -> string list
(** [make_dic d] is a list of all string words inside the association
    list represented by [d]. *)

val generate_word_bank : int -> string list -> string list
(** [generate_word_bank n d] is a string list of all strings inside [d]
    that are of length [n]. *)

val choose_random_word : string list -> string
(** [choose_random_word d] is a random string inside of the string list
    represented by [d]. *)

val is_word : string -> string list -> bool
(** [is_word w d] is true if [w] is a member of [d]. It is false
    otherwise. *)

val make_hidden_words : string -> string list -> string list
(** [make_hidden_words] takes a string of value "small", "medium",
    "large" and returns a string list of 4, 8 , 12 respectively*)

val make_game_board : string list -> char list list