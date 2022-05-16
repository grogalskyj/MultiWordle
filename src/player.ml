type player = {
  username : string;
  password : string;
  score_history : (int * int) list;
}

let make_player username password =
  { username; password; score_history = [] }

let update_player last_game_length last_game_guesses user =
  let old_score_history = user.score_history in
  user.score_history
  = (last_game_length, last_game_guesses) :: old_score_history
