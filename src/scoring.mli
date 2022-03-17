val score_input : string -> string-> int -> string
(** [score_input user_input correct_word] generates an output string that 
indicates the correctness of the input string. The output string will be 
generated based on three cases. 1). The output string will feature an uppercase 
character if the input string has the same character and in the same index of 
  the string as the string correct_word. 2). The output string will feature 
a lowercase character if the input string contains a letter in the 
correct_word, but it is in the wrong index. 3). The output string will 
feature a '_' if the given letter in the input string is not in correct_word. 
  Examples:
  score_input "lover" "bands" will output "_ _ _ _ _",
  score_input "lover" "ocean" will output "o _ e _ _",
  score input_ "lover" "cover" will output "_ O V E R" *)

val give_feedback : State.state -> string
(** [give_feedback game_state] generates a string informing the user how their guess
was scored against the correct word. The output string will be 
"You guessed" + word guessed + ", our output is the following: " + scored output
+ ". You have " + guesses remaining + " guesses remaining."*)

