val games_played : string -> (int * int) list -> int
(** [games_played username score_history] calculates the total number of
    games that a specific user has played.*)

val average_guesses : string -> int -> int