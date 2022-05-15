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

let rec game_iter_one game_state =
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
    print_word_bank new_game_state.char_bank alphabet guess;
    if check_game_over new_game_state then
      print_endline "Please play again!\n\n"
    else game_iter_one new_game_state)

let game_iter_two game_state = game_iter_one game_state
(* let game_start_wager game_state = print_endline "Instructions:
   Welcome to WagerWordle. Your object is to guess a \ predetermined
   word of length 3-10 before your opponent. You and \ your opponent
   will each be given a starting WordleCoin balance of \ 100. Each /\n\
   \ round you will be prompted to wager a some portion of your \
   balance on the gamble that you will guess the word before your \
   opponent. Wagers from you and your opponent will be pooled \ together
   each round, and the player that guesses the word first \ will redeem
   the pot. Additionally, you will be prompted to \ project how many
   guesses it will \n\ \ take you to guess the word. If you win the
   round AND correctly \ predict \n\ \ number of guesses you will need,
   you will receive an additional \ 10% of pot value directly from your
   opponent's WordleCoin \ balance. The first player to reach 0
   WordleCoins loses."; get_wager game_state *)

(* let rec check_acceptable (accept : int list) (input : string) = let
   input_int = int_of_string input in match accept with | [] -> false |
   h :: t -> if input_int = h then true else check_acceptable t input

   let get_num_letters : int = let acceptable_input = [ 3; 4; 5; 6; 7;
   8; 9; 10 ] in ANSITerminal.print_string [ ANSITerminal.yellow ] "What
   size words would you like to play with? Please enter a \ number 3 -
   10: "; let s = read_line () in if check_acceptable acceptable_input s
   then int_of_string s else 5 *)

let rec play_game (num : int) =
  let game_state = init_game_state num in
  ANSITerminal.print_string [ ANSITerminal.red ] "\nGAME MODE\n";
  print_endline
    "Select one of the game modes below to get started\n\
     One Player | Two Player | WagerWordle";
  print_string "> ";
  let input = read_line () in
  match input with
  | "One Player" -> game_iter_one game_state
  | "Two Player" -> game_iter_two game_state
  (* | "WagerWordle" -> game_start_wager game_state *)
  | _ ->
      print_endline "You did not enter a valid command";
      play_game num

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
