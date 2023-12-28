open Cryptokit
open Str

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

let sum_of_list lst =
  List.fold_left (fun acc x -> acc + x) 0 lst

let md5_hash plaintext =
  let hash = Hash.md5 () in
  hash#add_string plaintext;
  let hashed = hash#result in
  transform_string (Hexa.encode()) hashed

let combine prefix counter =
  Printf.sprintf "%s%d" prefix counter

let starts_with prefix word =
  string_match (regexp ("^" ^ prefix)) word 0

let solve line = 
  let rec find_hash prefix counter =
    let hash =  combine prefix counter |> md5_hash in
    if starts_with "000000" hash then
      counter
    else 
      find_hash prefix (counter + 1)
    in
  
  find_hash line 0

let solves lines =
  let ans = sum_of_list (List.map solve lines) in
  Printf.printf "Count: %d\n" (ans)


let () =
  solves lines
