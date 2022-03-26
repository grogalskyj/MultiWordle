
open OUnit2
open Game
open Scoring
open State
open Data_processing


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


let check_start_game_tst (name: string)(input: char)(expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (check_start_game input)

let word_bank = Yojson.Basic.from_file "dictionary.json"
let dic = generate_word_bank (word_bank)(5)



let rec check_word_length (word_list : string list)(len : int) =  match word_list with
| h :: t -> if String.length h <> len then false else check_word_length t len
| [] -> true

let  generate_word_bank_test (name : string)(dic : Yojson.Basic.t)(num_letters : int)(expected_output: bool) = 
  name >:: fun _  -> assert_equal expected_output (check_word_length (generate_word_bank (dic)(num_letters)) (num_letters))


let choose_random_word_test (name: string)(dic_list: string list)(expected_output : bool ) = 
   name >:: fun _ -> assert_equal expected_output ((choose_random_word dic_list) = (choose_random_word dic_list))


let score_input_tests = 
  [
    
    

  ]
let data_processing_tests=
  [
  check_start_game_tst 
"This tests the specification that if the user wants to start the game by pressing 's', the function returns true"
  's'  true ;
check_start_game_tst
"This tests that if the user doesn't pass in s, the game does not start" 'b' false;
generate_word_bank_test "Tests if all words generated in list are of length 5" word_bank 5 true;
generate_word_bank_test "Tests for really long strinngs are all same lenght" word_bank 14 true;
choose_random_word_test "Check if words are they same... they shouldn't be..." (dic) false;



]



  let suite =
    "test suite for MultiWordle"
    >::: List.flatten [ score_input_tests;
    data_processing_tests]
  
  let _ = run_test_tt_main suite

  (* Testing for state *)
  let word_length = 5
  let st = init_game_state word_length

  let state_tests = [
    ("The word in newly-initiated state is of the proper length" >:: fun _ -> assert_equal word_length (String.length st.word));
    ("The remaining guesses of newly-initiated state is 6" >:: fun _ -> assert_equal 6 st.remaining_guesses);
    ("The current guess of newly-initiated state is the empty string" >:: fun _ -> assert_equal "" st.curr_guess);
  ]
