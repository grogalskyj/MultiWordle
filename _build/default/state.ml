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
let update_state (game_state : state) (new_guess : string) : state =
  {word = game_state.word; 
  remaining_guesses = game_state.remaining_guesses - 1; 
  curr_guess = new_guess}
let check_game_over (game_state : state) : bool =
  if game_state.curr_guess = game_state.word then
    let _ = game_over in true
  else if game_state.remaining_guesses = 0 then true
  else false