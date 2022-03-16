let rec score_input user_input correct_word start_index = 
  match user_input with
  | _ -> "hi"
  (**
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


let give_feedback game_state user_input correct_word = 
  if game_state.remaining_guesses = 0 then feedback_helper "OUT OF LIVES" else
    "hi"


let feedback_helper user_input correct_word lives feedback= function
  | "OUT OF LIVES" -> "You guessed "^user_input^". The correct word was "^correct_word^". You are out of lives. GAME OVER."
  | "YOU WIN" -> "You guessed the word "^correct_word^" with "lives.to_String^" lives remaining. YOU WIN!"
  | "KEEP GOING" ->"You guessed the word "^user_input^". Here is your feedback: "^feedback^". You have "^lives.to_String^" lives remaining."
    
  
  (** Messages to come
    
    OUT OF LIVES: You guessed ___. The correct word was ___. You are out of lives. GAME OVER.
    
    YOU WIN: You guessed the word ___ with ___ lives remaining! YOU WIN.
    
    KEEP GOING: You guessed ___. Here is your feedback: ___. You have ___ guesses remaining.
    
    *)

