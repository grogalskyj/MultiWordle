(* check_start_game (user_input : char) : bool = true if ‘s’ has been
   entered, false otherwise

   generate_word_bank (input_json : Yojson.Basic.t) (num_letters : int)
   : string list = generates a list of English words that are of length
   num_letters Link to English Dict. JSON
   https://gist.github.com/BideoWego/60fbd40d5d1f0f1beca11ba95221dd38

   choose_random_word (word_bank : string list) : string = generates a
   random word from the given word bank *)

val choose_random_word : string list -> string
(*randomly chooses one string from string list*)

val generate_word_bank : Yojson.Basic.t -> int -> string list

(*generates of string list of all words in dictionary of length n (where
  n is 3<n<30) based on user input*)

val check_start_game : char -> bool
(*Checks if user has initialized Wordle game*)
