(* open State *)
open String

let rec string_to_string_list str = 
  match str with
  | "" -> []
  | some_input -> if length some_input = 1 then [some_input] 
  else sub some_input 0 1 :: string_to_string_list (sub (some_input)(1)((length some_input) -1))
    
(* let compare_letter_correctness (letter1 : string) (letter2 : string) : string  = 
  if letter1 = letter2 then uppercase_ascii letter1 
  else  "hi" *)


(* let check_letter (letter : string)(correct_word : string list) : string =

    
    
(* str and correct_word_str_list are both string lists*)
let score_helper (str_list : string list) (correct_word_str_list : string list) 
(correct_word : string) : string = match str_list with 
| h :: t -> 
| [] -> "" *)




  (* (List.iter2 compare_letter_correctness str_list correct_word_str_list)  *)
  (* |>  *)


  let rec score_helper (count : int) (str_list : string list) (correct_word_str_list : string list) : string =
    if count = List.length str_list then "" else 
    let str_first_letter = List.nth str_list count in
      let correct_str_first_letter = List.nth correct_word_str_list count in
        if str_first_letter = correct_str_first_letter then uppercase_ascii str_first_letter ^ score_helper (count + 1) str_list correct_word_str_list
        else if List.mem str_first_letter correct_word_str_list then str_first_letter ^ score_helper (count + 1) str_list correct_word_str_list
        else "_" ^ score_helper (count + 1) str_list correct_word_str_list


let score_input (user_input : string) (correct_word : string) : string = 
  (* assert ((String.length correct_word) = (String.length user_input)); *)
  match user_input with
    | "" -> let len = length correct_word in make len '_'
    | input -> score_helper 0 (input |> lowercase_ascii |> string_to_string_list) (correct_word |> string_to_string_list)


  (* user_input ^ correct_word ^ Stdlib.string_of_int (start_index) *)
  

(* Possible inputs
"" -> "_ _ _ _ _"
correct word

*)





  (* match user_input with
  | "" -> ""
  | _ -> if
    String.lowercase_ascii (String.sub user_input start_index 1) = 
    String.lowercase_ascii (String.sub correct_word start_index 1) 
  then
    String.uppercase_ascii (String.sub correct_word start_index 1) 
  ^
    score_input (String.sub (user_input) (start_index+1) ((String.length (user_input))-1))  
    (String.sub (correct_word) (start_index+1) ((String.length (correct_word))-1)) (start_index+1)

  else 
    "_ " 
  ^  
    score_input (String.sub (user_input) (start_index+1) ((String.length (user_input))-1))
    (String.sub (correct_word) (start_index+1) ((String.length (correct_word))-1)) (start_index+1) *)

    (* let feedback_helper user_input correct_word lives feedback= function
  | "OUT OF LIVES" -> "You guessed "^user_input^". The correct word was "^correct_word^". You are out of lives. GAME OVER."
  | "YOU WIN" -> "You guessed the word "^correct_word^" with " ^string_of_int lives^" lives remaining. YOU WIN!"
  | "KEEP GOING" ->"You guessed the word "^user_input^". Here is your feedback: "^feedback^". You have "^string_of_int lives^" lives remaining."
  | _ -> "Something weird happened here..." *)


(* let give_feedback game_state user_input correct_word = raise (Failure "Unimplemented: game_state") *)

  (* if game_state.remaining_guesses = 0 then feedback_helper "OUT OF LIVES" else
    if game_state.remaining_guesses >= 0 && String.lowercase_ascii user_input <> String.lowercase_ascii correct_word then
      feedback_helper "KEEP GOING" else feedback_helper "YOU WIN"  *)


(**Intended Messages
    
    OUT OF LIVES: You guessed ___. The correct word was ___. You are out of lives. GAME OVER.
    
    YOU WIN: You guessed the word ___ with ___ lives remaining! YOU WIN.
    
    KEEP GOING: You guessed ___. Here is your feedback: ___. You have ___ guesses remaining.
    
    *)
    
  
 


