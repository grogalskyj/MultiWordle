open Game
open State

let print_state_data (curr_state : state) : unit =
  print_endline ("Word: " ^ curr_state.word ^ " | Remaining Guesses: "
    ^ string_of_int curr_state.remaining_guesses ^ " | Current Guess: " ^ curr_state.curr_guess)
let create_state : unit = print_state_data (init_game_state 5)

let _ = create_state