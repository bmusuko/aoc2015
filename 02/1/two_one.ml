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


let split_and_convert line delimiter = 
  let substrings = String.split_on_char delimiter line in
  List.map int_of_string substrings

let solve line =
  
  let list = split_and_convert line 'x' in
  let nums = Array.of_list list in

  let a = nums.(0) * nums.(1) in 
  let b = nums.(0) * nums.(2) in
  let c = nums.(1) * nums.(2) in
  let perimeter = 2 * (a+b+c)  in
  let min = if a > b then b else a in
  let min = if min > c then c else min in

  perimeter + min

let sum_of_list lst =
  List.fold_left (fun acc x -> acc + x) 0 lst

  let solves lines =
  let ans = sum_of_list (List.map solve lines) in
  Printf.printf "Count: %d\n" (ans)



let () =
  solves lines
