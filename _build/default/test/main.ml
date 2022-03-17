open OUnit2
open Data_processing
open Scoring
open State

(** [score_input_test name user_input correct_word expected_output] constructs 
an OUnit test named [name] that assets the quality of [expected_output] with 
[score_inout input]*)
let score_input_test (name : string) (user_input : string) (correct_word : string)
(expected_output : string) = 
  name >:: fun _ -> assert_equal expected_output 
  (score_input user_input correct_word) ~printer

let score_input_tests = 
  [
    "INSERT TESTS HERE"
  ]