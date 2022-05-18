type wordsearch_state = {
  dictionary : string list;
  hidden_words : string list;
  found_words : string list;
  start_time : float;
  game_board : char list list;
}

val init_wordsearch_game_state : string -> wordsearch_state