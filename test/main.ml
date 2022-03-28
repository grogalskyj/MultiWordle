open OUnit2
open Game
open State
open Data_processing

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [score_input_test name user_input correct_word start_index expected_output]
    constructs an OUnit test named [name] that assets the quality of
    [expected_output] with [score_inout input]*)
let score_input_test
    (name : string)
    (user_input : string)
    (correct_word : string)
    (expected_output : string) =
  name >:: fun _ ->
  assert_equal expected_output
    (Scoring.score_input user_input correct_word)
    ~printer:pp_string

let check_start_game_tst
    (name : string)
    (input : char)
    (expected_output : bool) : test =
  name >:: fun _ ->
  assert_equal expected_output (check_start_game input)

let word_bank = Yojson.Basic.from_file "dictionary.json"
let dic = generate_word_bank word_bank 5

let rec check_word_length (word_list : string list) (len : int) =
  match word_list with
  | h :: t ->
      if String.length h <> len then false else check_word_length t len
  | [] -> true

let generate_word_bank_test
    (name : string)
    (dic : Yojson.Basic.t)
    (num_letters : int)
    (expected_output : bool) =
  name >:: fun _ ->
  assert_equal expected_output
    (check_word_length (generate_word_bank dic num_letters) num_letters)

let choose_random_word_test
    (name : string)
    (dic_list : string list)
    (expected_output : bool) =
  name >:: fun _ ->
  assert_equal expected_output
    (choose_random_word dic_list = choose_random_word dic_list)

let scoring_tests =
  [
    score_input_test "Empty input" "" "bands" "_____";
    score_input_test "Guessed correct word" "bands" "bands" "BANDS";
    score_input_test "Proper feedback" "hates" "bands" "_A__S";
    score_input_test "Proper feedback 2" "money" "epoxy" "_o_eY"
    (* score_input_test "Input with no correct letters" "lover" "bands"
       0 "_ _ _ _ _" *);
  ]

let data_processing_tests =
  [
    check_start_game_tst
      "This tests the specification that if the user wants to start \
       the game by pressing 's', the function returns true"
      's' true;
    check_start_game_tst
      "This tests that if the user doesn't pass in s, the game does \
       not start"
      'b' false;
    generate_word_bank_test
      "Tests if all words generated in list are of length 5" word_bank 5
      true;
    generate_word_bank_test
      "Tests for really long strinngs are all same lenght" word_bank 14
      true;
    choose_random_word_test
      "Check if words are they same... they shouldn't be..." dic false;
  ]

let word_length = 5
let st1 = init_game_state word_length
let new_guess1 = "epoxy"
let st2 = update_game_state st1 new_guess1
let new_guess2 = st2.word
let st3 = update_game_state st2 new_guess2
let st4 = { st3 with remaining_guesses = 0 }

let state_tests =
  [
    ( "The word in newly-initiated state is of the proper length"
    >:: fun _ -> assert_equal word_length (String.length st1.word) );
    ( "The remaining guesses of newly-initiated state is 6" >:: fun _ ->
      assert_equal 6 st1.remaining_guesses );
    ( "The current guess of newly-initiated state is the empty string"
    >:: fun _ -> assert_equal "" st1.curr_guess );
    ( "Updating a game state does not change the designated word"
    >:: fun _ -> assert_equal st1.word st2.word );
    ( "Updating a game state reduces the number of guesses by 1"
    >:: fun _ ->
      assert_equal st2.remaining_guesses (st1.remaining_guesses - 1) );
    ( "Updating a game state changes the current guess to the new guess"
    >:: fun _ -> assert_equal new_guess1 st2.curr_guess );
    ( "An ongoing game where there are remaining guesses left and \
       where the word has not beet guessed is not over"
    >:: fun _ -> assert_equal false (check_game_over st2) );
    ( "A game is over if the designated word has been guessed"
    >:: fun _ -> assert_equal true (check_game_over st3) );
    ( "A game is over if there are no remaining guesses" >:: fun _ ->
      assert_equal true (check_game_over st4) );
  ]

let suite =
  "test suite for MultiWordle"
  >::: List.flatten
         [ scoring_tests; state_tests; data_processing_tests ]

let _ = run_test_tt_main suite

(* Testing for state *)
