open OUnit2
open Game
open Scoring
open State

(** [score_input_test name user_input correct_word start_index expected_output] constructs 
an OUnit test named [name] that assets the quality of [expected_output] with 
[score_inout input]*)
let score_input_test (name : string) (user_input : string) (correct_word : string)
(start_index : int)
(expected_output : string) = 
  name >:: fun _ -> assert_equal expected_output 
  (score_input user_input correct_word start_index)

let score_input_tests = 
  [
    
    

  ]

  let word_length = 5
  let st1 = init_game_state word_length
  let new_guess1 = "epoxy"
  let st2 = update_game_state st1 new_guess1
  let new_guess2 = st2.word
  let st3 = update_game_state st2 new_guess2
  let st4 = {st3 with remaining_guesses = 0}
  let state_tests = [
    ("The word in newly-initiated state is of the proper length" >:: fun _ -> assert_equal word_length (String.length st1.word));
    ("The remaining guesses of newly-initiated state is 6" >:: fun _ -> assert_equal 6 st1.remaining_guesses);
    ("The current guess of newly-initiated state is the empty string" >:: fun _ -> assert_equal "" st1.curr_guess);

    ("Updating a game state does not change the designated word" >:: fun _ -> assert_equal st1.word st2.word);
    ("Updating a game state reduces the number of guesses by 1" >:: fun _ -> assert_equal st2.remaining_guesses (st1.remaining_guesses - 1));
    ("Updating a game state changes the current guess to the new guess" >:: fun _ -> assert_equal new_guess1 st2.curr_guess);

    ("An ongoing game where there are remaining guesses left and where the word has not beet guessed is not over" >:: fun _ -> assert_equal false (check_game_over st2));
    ("A game is over if the designated word has been guessed" >:: fun _ -> assert_equal true (check_game_over st3));
    ("A game is over if there are no remaining guesses" >:: fun _ -> assert_equal true (check_game_over st4))
  ]
  let suite =
    "test suite for MultiWordle"
    >::: List.flatten [ score_input_tests; state_tests]
  
  let _ = run_test_tt_main suite

  (* Testing for state *)
  

  

