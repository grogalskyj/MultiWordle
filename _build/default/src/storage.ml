open Player

type player_database = (string * player) list

let rec get_usernames (database : player_database) : string list =
  match database with
  | [] -> []
  | [ (h, _) ] -> [ h ]
  | (h, _) :: t -> h :: get_usernames t

let get_player_record (username : string) (database : player_database) :
    player =
  let usernames_list = get_usernames database in
  if List.mem username usernames_list then List.assoc username database
  else failwith "Player does not exist"

let games_played (username : string) (database : player_database) : int
    =
  let player_record = get_player_record username database in
  List.length player_record.game_history

let average_guesses (username : string) (database : player_database) :
    int =
  let player_record = get_player_record username database in
  5

let guess_trend username player_database = 5
