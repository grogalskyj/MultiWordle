open Yojson.Basic.Util
open Data_processing

let dictionary_json = "dictionary.json"

type state = {
  dictionary : string list;
  mutable word : string;
  remaining_guesses : int;
  curr_guess : string;
  char_bank : char list;
}

type wordsearch_state = {
  dictionary : string list; (*dictionary to draw words from*)
  hidden_words : string list; (*list of words in the word search*)
  found_words : string list;
  (*list of words correctly guessed by the user*)
  start_time : float;
  game_board : char list list;
      (*start tim eof the game, used to time how long they take*)
}

let init_wordsearch_game_state (size : string) : wordsearch_state =
  let dict =
    Yojson.Basic.from_file dictionary_json |> to_assoc |> make_dic
  in
  let hidden_words = make_hidden_words size dict in
  {
    dictionary = dict;
    hidden_words;
    found_words = [];
    start_time = Sys.time ();
    game_board = make_game_board hidden_words;
  }

let init_game_state (num_letters : int) : state =
  {
    dictionary =
      Yojson.Basic.from_file dictionary_json |> to_assoc |> make_dic;
    word =
      Yojson.Basic.from_file dictionary_json
      |> to_assoc |> make_dic
      |> generate_word_bank num_letters
      |> choose_random_word;
    remaining_guesses = 6;
    curr_guess = "";
    char_bank = [];
  }
(*['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z']*)

let update_char_bank (char_bank : char list) (guess : string) :
    char list =
  let char_list = List.init (String.length guess) (String.get guess) in
  List.append char_list char_bank |> List.sort_uniq compare

let update_game_state (game_state : state) (new_guess : string) : state
    =
  {
    dictionary = game_state.dictionary;
    word = game_state.word;
    remaining_guesses = game_state.remaining_guesses - 1;
    curr_guess = new_guess;
    char_bank =
      update_char_bank game_state.char_bank (new_guess : string);
  }

let check_game_over (game_state : state) : bool =
  if game_state.curr_guess = game_state.word then (
    print_endline "Congrats you guessed the word!\n";
    true)
  else if game_state.remaining_guesses = 0 then (
    print_endline
      ("You ran out of guesses. The correct word was " ^ game_state.word);
    true)
  else false

let to_string (game_state : state) : string =
  "Word: " ^ game_state.word ^ " | Remaining Guesses: "
  ^ string_of_int game_state.remaining_guesses
  ^ " | Current Guess: " ^ game_state.curr_guess
