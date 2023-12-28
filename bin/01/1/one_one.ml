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


let solve line =
  let rec count pattern =
    match pattern with
    | [] -> 0
    | head::tail -> 
        if head = '(' then 1 + count tail
        else -1 + count tail
  in

let string_to_char_list str =
  str |> String.to_seq |> List.of_seq 
in

let answer = count (string_to_char_list line) in

Printf.printf "Count: %d\n" (answer)



let () =
  List.iter solve lines
