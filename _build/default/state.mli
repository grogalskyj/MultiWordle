type state = {word : string; remaining_guesses : int; curr_guess : string}
(** The type state is a record that stores all the information for the
current game being played. [word] is a string that stores the word that the
player must guess, [remaining_guesses] is an int that stores the amount of
guesses that the player has before losing, and [curr_guess] is a string that
stores the more recent guess made by the player. *)

type game_status =
| Instructions
| Playing
| GameOver
(** The type game_status is a variant that stores the different modes that the
game may be in. *)

val init_game_state : int -> state
(** [init_game_state n] is a newly generated state with [remaining_guesses]
set to 6, [word] set to a random string in the English alphabet of length [n],
and [curr_guess] set to the empty string. *)

val update_game_state : state -> string -> state
(** [update_game_state st g] is a state with one less guess than [st] and with
[curr_guess] set to [g]*)

val check_game_over : state -> bool
(** [check_game_over st] is true if the player has guessed the word or has no
  remaining guesses. It is false otherwise. *)