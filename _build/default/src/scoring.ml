
let rec score_input user_input correct_word start_index = 
  match user_input with
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
    (String.sub (correct_word) (start_index+1) ((String.length (correct_word))-1)) (start_index+1)

(* 
    let feedback_helper user_input correct_word lives feedback= function
  | "OUT OF LIVES" -> "You guessed "^user_input^". The correct word was "^correct_word^". You are out of lives. GAME OVER."
  | "YOU WIN" -> "You guessed the word "^correct_word^" with " ^string_of_int lives^" lives remaining. YOU WIN!"
  | "KEEP GOING" ->"You guessed the word "^user_input^". Here is your feedback: "^feedback^". You have "^string_of_int lives^" lives remaining."
  | _ -> "Something weird happened here..." *)


(* let give_feedback game_state user_input correct_word = 
  if game_state.remaining_guesses = 0 then feedback_helper "OUT OF LIVES" else
    if game_state.remaining_guesses >= 0 && String.lowercase_ascii user_input <> String.lowercase_ascii correct_word then
      feedback_helper "KEEP GOING" else feedback_helper "YOU WIN" *)


(**Intended Messages
    
    OUT OF LIVES: You guessed ___. The correct word was ___. You are out of lives. GAME OVER.
    
    YOU WIN: You guessed the word ___ with ___ lives remaining! YOU WIN.
    
    KEEP GOING: You guessed ___. Here is your feedback: ___. You have ___ guesses remaining.
    
    *)
    
  
 


