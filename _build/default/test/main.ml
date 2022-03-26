open OUnit2
open Game

(* open Data_processing

open State *)

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [score_input_test name user_input correct_word start_index expected_output] constructs 
an OUnit test named [name] that assets the quality of [expected_output] with 
[score_inout input]*)
let score_input_test (name : string) (user_input : string) (correct_word : string)
(expected_output : string) = 
  name >:: fun _ -> assert_equal expected_output 
  (Scoring.score_input user_input correct_word) ~printer: pp_string

let scoring_tests = 
  [
    score_input_test "Empty input" "" "bands" "_____";
    score_input_test "Guessed correct word" "bands" "bands" "BANDS";
    score_input_test "Proper feedback" "hates" "bands" "_A__S";
    score_input_test "Proper feedback 2" "money" "epoxy" "_o_eY"


    (* score_input_test "Input with no correct letters" "lover" "bands" 0 "_ _ _ _ _" *)
    


  ]



  let suite =
    "test suite for MultiWordle"
    >::: List.flatten [ scoring_tests ]
  
  let _ = run_test_tt_main suite