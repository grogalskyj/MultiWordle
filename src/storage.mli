open Player

type player_database = (string * player) list
(** [player_database] is a list containing each player's username and
    the corresponding player type that matches the corresponding
    username*)

val games_played : string -> player_database -> int
(** [games_played username player_database] calculates the total number
    of games that a specific user has played.*)

val average_guesses : string -> player_database -> int
(** [average_guesses username player_database] calculates the average
    number of guesses it takes a specific user to guess a word.*)

val guess_trend : string -> player_database -> int
(** [recent_guess-trend username player_database] calculates the average
    number of guess it has taken a specific user to guess a word in
    their last 3 games played. *)
