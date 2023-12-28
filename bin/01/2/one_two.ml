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
  let rec count pattern sum idx =
    match pattern with
    | [] -> -1
    | head::tail -> 
        let new_sum =  if head = ')'  then sum  -1 else sum + 1 in
        if new_sum = -1 then
          idx
        else
           count tail new_sum idx+1
  in

  let string_to_char_list str =
    str |> String.to_seq |> List.of_seq 
  in

  let answer = count (string_to_char_list line) 0 1 in

  Printf.printf "Count: %d\n" (answer)



let () =
  List.iter solve lines
