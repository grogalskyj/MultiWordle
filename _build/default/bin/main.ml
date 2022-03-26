open Game
open State
open Scoring
 
let rec game_iter game_state =
 print_endline ("Your guess: ");
 print_string "> ";
 let guess = read_line () in
   print_endline (score_input guess game_state.word 0);
   let new_game_state = update_game_state game_state guess in
   if check_game_over new_game_state then print_endline "You guessed the word!"
   else game_iter new_game_state
 
let play_game () =
 let game_state = init_game_state 5 in
 game_iter game_state
 
let main () =
 ANSITerminal.print_string [ ANSITerminal.red ]
   "\n\nWelcome to the MultiWordle game.\n";
 print_endline "Instructions: blah \n";
 print_string "> ";
 match read_line () with
 | "s" -> play_game ()
 | _ -> print_endline "You did not enter a valid command"