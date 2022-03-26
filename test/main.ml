open OUnit2
open Game
open Scoring

(* open Data_processing

open State *)


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



  let suite =
    "test suite for MultiWordle"
    >::: List.flatten [ score_input_tests;]
  
  let _ = run_test_tt_main suite