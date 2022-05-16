type player = {
  username : string;
  password : string;
  game_history : (int * int) list;
}

let make_player username password =
  { username; password; game_history = [] }

let update_player last_game_length last_game_guesses user =
  let old_score_history = user.game_history in
  (last_game_length, last_game_guesses) :: old_score_history
