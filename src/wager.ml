open State

type player1 = { coin_balance : int }

let get_wager (game_state : state) = game_state

(* let wager_prompt (coin_balance : int) game_state = let s = "Your
   WordleCoin balance is: " ^ string_of_int coin_balance ^ "." in
   print_endline s; let word_length = Random.int 10 + 1 in let s' = "The
   word-length for this round is: " ^ string_of_int word_length ^ "." in
   print_endline s'; print_endline "How much do you wager that you will
   guess the word before your \ opponent?"; print_string "> "; let input
   = read_line () in match input with | _ -> 5 *)
