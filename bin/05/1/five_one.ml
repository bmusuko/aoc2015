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

let bool_to_int is_true = 
  if is_true then
    1
  else 
    0

let string_to_char_list str =
  str |> String.to_seq |> List.of_seq


let first_condition chars =
  let rec check pattern count =
    if count == 0 then
      true
    else 
      match pattern with
      | [] -> false
      | head::tail ->
        if head = 'a' || head = 'i' || head = 'u' || head = 'e' || head = 'o' then
          check tail (count-1)
        else 
          check tail count
  in

  check chars 3

let second_condition chars =
  let rec check pattern =
    match pattern with
    | [] -> false
    | [_] -> false
    | head::next::tail ->
      if head == next then 
        true
    else 
      check (next::tail)
  in

  check chars

let third_condition chars = 
  let rec check pattern =
    match pattern with
    | [] -> true
    | [_] -> true
    | head::next::tail ->
      if (((Char.code head) + 1) == (Char.code next) && (head = 'a' || head = 'c' || head = 'p' || head = 'x')) then 
        false
    else 
      check (next::tail)
  in

  check chars
  
let solve line = 
  let chars = string_to_char_list line in
  (first_condition chars) && (second_condition chars) && (third_condition chars)



let solves lines =
  let ans' = List.map solve lines in
  let ans = sum_of_list (List.map bool_to_int ans') in
  Printf.printf "Count: %d\n" (ans)


let () =
  solves lines
