open Game
open Data_processing
open State
open Scoring
(* open Wager *)

let alphabet =
  [
    'q';
    'w';
    'e';
    'r';
    't';
    'y';
    'u';
    'i';
    'o';
    'p';
    'a';
    's';
    'd';
    'f';
    'g';
    'h';
    'j';
    'k';
    'l';
    'z';
    'x';
    'c';
    'v';
    'b';
    'n';
    'm';
  ]

let rec game_iter_one game_state : state =
  print_endline "\nYour guess: ";
  print_string "> ";
  let guess = read_line () in
  if String.length guess <> String.length game_state.word then (
    print_endline
      "You did not enter a string of valid length. Please try again.";
    game_iter_one game_state)
  else if is_word guess game_state.dictionary = false then (
    print_endline "You did not enter a valid word. Please try again.";
    game_iter_one game_state)
  else (
    print_colored_feedback (score_input guess game_state.word);
    let new_game_state = update_game_state game_state guess in
    print_word_bank new_game_state alphabet;
    if check_game_over new_game_state = false then
      game_iter_one new_game_state
    else new_game_state)

let rec game_iter_two_state_update (game_state : state) : unit =
  print_string "> ";
  let input_word = read_line () in
  if String.length input_word <> String.length game_state.word then (
    print_endline
      "You did not enter a string of valid length. Please try again.";
    game_iter_two_state_update game_state)
  else if is_word input_word game_state.dictionary = false then (
    print_endline "You did not enter a valid word. Please try again.";
    game_iter_two_state_update game_state)
  else game_state.word <- input_word

let rec game_iter_two
    (player_one_game_state : state)
    (player_two_game_state : state)
    (player_one_points : int)
    (player_two_points : int)
    (round_number : int) =
  if round_number = 6 then
    if player_one_points > player_two_points then
      ANSITerminal.print_string [ ANSITerminal.blue ]
        "\nPlayer 1 won!\n"
    else if player_one_points < player_two_points then
      ANSITerminal.print_string [ ANSITerminal.blue ]
        "\nPlayer 2 won!\n"
    else
      ANSITerminal.print_string [ ANSITerminal.blue ]
        "\nThe game ended in a tie\n"
  else (
    ANSITerminal.print_string [ ANSITerminal.red ]
      ("ROUND " ^ string_of_int round_number);
    print_endline "\nCurrent score:";
    print_endline
      ("PLAYER ONE: "
      ^ string_of_int player_one_points
      ^ " | PLAYER TWO: "
      ^ string_of_int player_two_points);
    print_endline
      "\nPLAYER ONE, please enter a word for PLAYER TWO to guess";
    game_iter_two_state_update player_two_game_state;
    print_endline "\nPLAYER TWO, your turn to guess";
    let player_one_round_points =
      (game_iter_one player_two_game_state).remaining_guesses
    in

    print_endline
      "\nPLAYER TWO, please enter a word for PLAYER ONE to guess";
    game_iter_two_state_update player_one_game_state;
    print_endline "PLAYER ONE, your turn to guess";
    let player_two_round_points =
      (game_iter_one player_one_game_state).remaining_guesses
    in

    game_iter_two
      (init_game_state (String.length player_one_game_state.word))
      (init_game_state (String.length player_one_game_state.word))
      (player_one_points + player_one_round_points)
      (player_two_points + player_two_round_points)
      (round_number + 1))

let rec play_game (num_letters : int) =
  ANSITerminal.print_string [ ANSITerminal.red ] "\nGAME MODE\n";
  print_endline
    "Select one of the game modes below to get started\n\
     One Player | Two Player | WagerWordle";
  print_string "> ";
  let input = read_line () in
  match String.lowercase_ascii input with
  | "one player" ->
      ANSITerminal.print_string [ ANSITerminal.red ]
        "\nONE PLAYER INSTRUCTIONS\n";
      print_endline
        "Welcome to one player mode! This mode simulates a classic \
         Wordle game where you have six attempts to guess a \
         predetermined word.";
      ignore (game_iter_one (init_game_state num_letters))
  | "two player" ->
      ANSITerminal.print_string [ ANSITerminal.red ]
        "\nTWO PLAYER INSTRUCTIONS\n";
      print_endline
        "Welcome to two player mode! Please first decide the player \
         that will be Player One and the player that will be Player \
         Two. This mode consists of five rounds, after which the \
         player with the most points will win. In each round, Player \
         One will choose a word that Player Two must guess, and then \
         Player Two will choose a word that Player One must guess. \
         Each player will have 6 guesses to guess their assigned word, \
         and if they guess the word in x tries, then they will earn (6 \
         - x) points for that round.\n";

      game_iter_two
        (init_game_state num_letters)
        (init_game_state num_letters)
        0 0 1
  (* | "WagerWordle" -> game_start_wager game_state *)
  | _ ->
      print_endline "You did not enter a valid command";
      play_game num_letters

let main () =
  ANSITerminal.print_string [ ANSITerminal.red ] "\n\nINSTRUCTIONS\n";
  print_endline
    "Welcome to MultiWordle! Your objective is to guess a \
     predetermined word (length is your choice) with only 6 guesses. \
     For every word that you guess, our system will output that exact \
     word, but with each letter colorcoded. A yellow letter means the \
     predetermined word has that letter, but the letter is in the \
     wrong place. A green letter means that the predetermined word has \
     that letter, and the letter is in the right place. An underscore \
     means that that letter is not in the predetermined word. To play, \
     enter a number between 3 and 10 to determine the length of the \
     word you will be guessing.\n";
  print_string "> ";
  let s = read_line () in
  try play_game (int_of_string s)
  with _ -> print_endline "You did not enter a valid command"

let () = main ()
