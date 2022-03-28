open Game
open State
open Scoring

(* Find way to represent _ as actual letter and not simply _*)
(* Also restrict word entering to only five letters! *)
let rec print_colored_feedback (str : string) =
  if String.length str = 0 then print_endline ""
  else if String.get str 0 = '_' then (
    print_string "_";
    print_colored_feedback (String.sub str 1 (String.length str - 1)))
  else if String.get str 0 >= 'a' && String.get str 0 <= 'z' then (
    ANSITerminal.print_string [ ANSITerminal.yellow ]
      (String.uppercase_ascii (String.make 1 (String.get str 0)));
    print_colored_feedback (String.sub str 1 (String.length str - 1)))
  else if String.get str 0 >= 'A' && String.get str 0 <= 'Z' then (
    ANSITerminal.print_string [ ANSITerminal.green ]
      (String.make 1 (String.get str 0));
    print_colored_feedback (String.sub str 1 (String.length str - 1)))
  else
    failwith
      ("The character "
      ^ String.make 1 (String.get str 0)
      ^ " is not a valid feedback character.")

let rec game_iter game_state =
  print_endline "Your guess: ";
  print_string "> ";
  let guess = read_line () in
  print_colored_feedback (score_input guess game_state.word);
  let new_game_state = update_game_state game_state guess in
  if check_game_over new_game_state then
    print_endline "You guessed the word!"
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

let () = main ()
