open OUnit2
open Yojson.Basic.Util
open Game
open State
open Data_processing
open Storage
open Player

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

let pp_int i = "\"" ^ string_of_int i ^ "\""

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

(** [make_player_test name username password expected_output] constructs
    an OUnit test named [name] that assets the quality of
    [expected_output] with [Player.make_player username password]*)
let make_player_test
    (name : string)
    (username : string)
    (password : string)
    (expected_output : player) =
  name >:: fun _ ->
  assert_equal expected_output (Player.make_player username password)

(** [update_player_test name last_game_length last_game_guesses user expected_output]
    constructs an OUnit test named [name] that assets the quality of
    [expected_output] with
    [Player.update_player last_game_length last_game_guesses user]*)
let update_player_test
    (name : string)
    (last_game_length : int)
    (last_game_guesses : int)
    (user : player)
    (expected_output : unit) =
  name >:: fun _ ->
  assert_equal expected_output
    (Player.update_player last_game_length last_game_guesses user)

(** [games_played_test name username player_database expected_output]
    constructs an OUnit test named [name] that assets the quality of
    [expected_output] with
    [Storage.games_played username player_database]*)
let games_played_test
    (name : string)
    (username : string)
    (player_database : (string * player) list)
    (expected_output : int) =
  name >:: fun _ ->
  assert_equal expected_output
    (Storage.games_played username player_database)
    ~printer:pp_int

(** [average_guesses_test player expected_output] constructs an OUnit
    test named [name] that assets the quality of [expected_output] with
    [Storage.get_average_guesses player]*)
let average_guesses_test
    (name : string)
    (player : player)
    (expected_output : int) =
  name >:: fun _ ->
  assert_equal expected_output
    (Storage.get_average_guesses player)
    ~printer:pp_int

(** [guess_trend_test guess_list expected_output] constructs an OUnit
    test named [name] that assets the quality of [expected_output] with
    [Storage.guess_trend guess_list]*)
let guess_trend_test
    (name : string)
    (guess_list : int list)
    (expected_output : int) =
  name >:: fun _ ->
  assert_equal expected_output
    (Storage.guess_trend guess_list)
    ~printer:pp_int

let check_start_game_tst
    (name : string)
    (input : char)
    (expected_output : bool) : test =
  name >:: fun _ ->
  assert_equal expected_output (check_start_game input)

let dic =
  Yojson.Basic.from_file "dictionary.json"
  |> to_assoc |> make_dic |> generate_word_bank 5

let rec check_word_length (word_list : string list) (len : int) =
  match word_list with
  | h :: t ->
      if String.length h <> len then false else check_word_length t len
  | [] -> true

(* let generate_word_bank_test (name : string) (dic : Yojson.Basic.t)
   (num_letters : int) (expected_output : bool) = name >:: fun _ ->
   assert_equal expected_output (check_word_length (dic |> make_dic |>
   generate_word_bank num_letters) num_letters) *)

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
    score_input_test "Guessed correct word 5 letter" "bands" "bands"
      "BANDS";
    score_input_test "Guessed correct word double-check" "beach" "beach"
      "BEACH";
    score_input_test "Guessed correct word different capitalization"
      "bAnDs" "bands" "BANDS";
    score_input_test "Proper feedback" "hates" "bands" "_A__S";
    score_input_test "Proper feedback 2" "money" "epoxy" "_o_eY";
    score_input_test "Input with no correct letters" "trunk" "beach"
      "_____";
    score_input_test "3 letter correct word" "bed" "bed" "BED";
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
    (* generate_word_bank_test "Tests if all words generated in list are
       of length 5" word_bank 5 true; generate_word_bank_test "Tests for
       really long strinngs are all same lenght" word_bank 14 true; *)
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

let player1 = make_player "bananalover34" "monkey"
let player2 = make_player "ocaml" "pragmaticprogrammer"
let player3 = update_player 4 5 (make_player "bananalover34" "monkey")

let player4 =
  update_player 5 6 (make_player "ocaml" "pragmaticprogrammer")

let player5 = make_player "username" "password"
let updated_player5 = update_player 3 4 player5

let player_tests =
  [
    make_player_test "player1 test" "bananalover34" "monkey" player1;
    make_player_test "player2 test" "ocaml" "pragmaticprogrammer"
      player2;
    update_player_test "adding one game of history to player1" 4 5
      player1 player3;
    update_player_test "adding one game of history to player2" 5 6
      player2 player4;
  ]

let no_player_database = init_database

let one_player_database =
  update_database "bananalover34"
    {
      username = "bananalover34";
      password = "monkey";
      game_history = [];
    }
    no_player_database

let two_player_database =
  update_database "ocaml"
    {
      username = "ocaml";
      password = "pragmaticprogrammer";
      game_history = [ (1, 2) ];
    }
    one_player_database

let storage_tests =
  [
    games_played_test "no games played" "bananalover34"
      one_player_database 0;
    games_played_test "one game played" "ocaml" two_player_database 1;
    average_guesses_test "no games played" player1 0;
    average_guesses_test "non-empty game history"
      (updated_player5;
       player5)
      4;
    guess_trend_test "no guesses" [] 0;
    guess_trend_test "one guess" [ 1 ] 1;
    guess_trend_test "two guesses" [ 1; 3 ] 2;
    guess_trend_test "three guesses" [ 2; 4; 6 ] 4;
    guess_trend_test "more than three guesses" [ 3; 4; 6; 7 ] 4;
  ]

let suite =
  "test suite for MultiWordle"
  >::: List.flatten
         [
           scoring_tests;
           state_tests;
           data_processing_tests;
           storage_tests;
           player_tests;
         ]

let _ = run_test_tt_main suite

(* Testing for state *)
