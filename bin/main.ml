open Game
open Data_processing
open State
open Scoring

let alphabet =
  [
    'a';
    'b';
    'c';
    'd';
    'e';
    'f';
    'g';
    'h';
    'i';
    'j';
    'k';
    'l';
    'm';
    'n';
    'o';
    'p';
    'q';
    'r';
    's';
    't';
    'u';
    'v';
    'w';
    'x';
    'y';
    'z';
  ]

(* let rec game_iter game_state = print_endline "Your guess: ";
   print_string "> "; let guess = read_line () in if String.length guess
   <> 5 then ( print_endline "You did not enter a string of valid\n\ \
   length. Please try again."; game_iter game_state) else if is_word
   guess game_state.dictionary = false then ( print_endline "You did
   not\n enter a valid word. Please try again."; game_iter game_state)
   else ( print_colored_feedback (score_input guess game_state.word); (*
   ANSITerminal.print_string [ ANSITerminal.green ] "here"; *) let
   new_game_state = update_game_state game_state guess in
   print_word_bank new_game_state.char_bank alphabet guess; if
   check_game_over new_game_state then print_endline "Please play\n
   again!" else game_iter new_game_state) *)

let rec game_iter game_state =
  print_endline "Your guess: ";
  print_string "> ";
  let guess = read_line () in
  if String.length guess <> 5 then (
    print_endline
      "You did not enter a string of valid length. Please try again.";
    game_iter game_state)
  else if is_word guess game_state.dictionary = false then (
    print_endline "You did not enter a valid word. Please try again.";
    game_iter game_state)
  else (
    print_colored_feedback (score_input guess game_state.word);
    let new_game_state = update_game_state game_state guess in
    print_word_bank new_game_state.char_bank alphabet guess;
    if check_game_over new_game_state then
      print_endline "Please play again!"
    else game_iter new_game_state)

let play_game () =
  let game_state = init_game_state 5 in
  game_iter game_state

let main () =
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\nWelcome to the MultiWordle game.\n";
  print_endline
    "Instructions: Welcome to MultiWordle! Your objective is to guess \
     a predetermined five-letter word with only 6 guesses. For every \
     word that you guess, our system will output that exact word, but \
     with each letter colorcoded. A yellow letter means the \
     predetermined word has that letter, but the letter is in the \
     wrong place. A green letter means that the predetermined word has \
     that letter, and the letter is in the right place. An underscore \
     means that that letter is not in the predetermined word. To play, \
     press \'s\'.\n";
  print_string "> ";
  match read_line () with
  | "s" -> play_game ()
  | _ -> print_endline "You did not enter a valid command"

let () = main ()
