let read_lines filename =
  let ic = open_in filename in
  try
    let rec read_all_lines acc =
      try
        let line = input_line ic in
        read_all_lines (line :: acc)
      with End_of_file ->
        close_in ic;
        List.rev acc
    in
    read_all_lines []
  with e ->
    close_in_noerr ic;
    raise e

let file = "../data/input.txt"
let lines = read_lines file

module SS = Set.Make(String);;


let get_key x y = 
  Printf.sprintf"%d#%d" x y

let string_to_char_list str =
  str |> String.to_seq |> List.of_seq

let sum_of_list lst =
  List.fold_left (fun acc x -> acc + x) 0 lst
let solve line = 
  let chars = string_to_char_list line in
  let rec count x y set pattern =
    match pattern with
    | [] -> SS.cardinal set
    | head :: tail ->
      let x, y =
        match head with
        | '^' -> (x - 1, y)
        | 'v' -> (x + 1, y)
        | '<' -> (x, y - 1)
        | '>' -> (x, y + 1)
        | _ -> (x, y)  (* Handle other characters as needed *)
      in
      let set = SS.add (get_key x y) set in
      count x y set tail
    in
  let set = SS.singleton (get_key 0 0) in
  
  count 0 0 set chars

let solves lines =
  let ans = sum_of_list (List.map solve lines) in
  Printf.printf "Count: %d\n" (ans)


let () =
  solves lines
