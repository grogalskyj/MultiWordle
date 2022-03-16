

let check_start_game (user_input : char) : bool = if user_input = 's' then true else false 

  
let rec query_dic (dic : (string * Yojson.Basic.t) list)(num_letters : int) = 
match dic with 
| [] -> []
| (name, _) :: t -> if (String.length name) == num_letters then name :: query_dic t num_letters else query_dic t num_letters


let generate_word_bank (dic :Yojson.Basic.t)(num_letters :int ) = query_dic (Yojson.Basic.Util.to_assoc dic) (num_letters)


let choose_random_word (dic_list : string list) : string = List.nth(dic_list)( Random.int (List.length dic_list))

