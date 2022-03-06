open Data_processing
open Scoring

type state = {word : string; remaining_guesses : int; curr_guess : string}

type game_status =
| Instructions
| Playing
| GameOver

let init_game_state (num_letters : int) : state =
  {word = num_letters |> generate_word_bank input_json |> choose_random_word;
  remaining_guesses = 6; curr_guess = ""}