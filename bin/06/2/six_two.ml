open Base

let read_lines filename =
  let ic = Stdlib.open_in filename in
  try
    let rec read_all_lines acc =
      try
        let line = Stdlib.input_line ic in
        read_all_lines (line :: acc)
      with End_of_file ->
        Stdlib.close_in ic;
        List.rev acc
    in
    read_all_lines []
  with e ->
    Stdlib.close_in_noerr ic;
    raise e

let file = "../data/input.txt"
let lines = read_lines file

let num_of_true matrix n =
  let count = ref 0 in

  for x = 0 to n-1 do
    for y = 0 to n-1 do
      count := !count + matrix.(x).(y)
      done 
    done;

  !count
  
let parse_coordinates str =
  match Stdlib.Scanf.sscanf str "%d,%d through %d,%d" (fun x1 y1 x2 y2 -> (x1, y1, x2, y2)) with
  | coordinates -> coordinates
  | exception _ -> failwith "Invalid coordinate format"

let apply_command matrix x1 y1 x2 y2 action =
  for x = x1 to x2 do
    for y = y1 to y2 do
      matrix.(x).(y) <- action matrix.(x).(y)
    done
  done

let maximum x y =
  if x > y then
    x
  else 
    y

let solve line matrix =
  match String.split ~on:' ' line with
  | "turn" :: "on" :: rest
  | "turn" :: "off" :: rest
  | "toggle" :: rest ->
    let x1, y1, x2, y2 = parse_coordinates (String.concat ~sep:" " rest) in
    let action =
      match String.split ~on:' ' line with
      | "turn" :: "on" :: _ -> (fun x -> x+1)
      | "turn" :: "off" ::_ -> (fun x -> maximum (x-1) 0)
      | "toggle" :: _ -> (fun x -> x+2)
      | _ -> failwith "Invalid command"
    in
    apply_command matrix x1 y1 x2 y2 action;
    matrix
  | _ -> matrix
  
  
let solves lines =
  let n = 1000 in
  let matrix = ref (Base.Array.make_matrix ~dimx:n ~dimy:n 0) in
  Stdlib.List.iter (fun line -> matrix := solve line !matrix) lines;
  let ans = num_of_true !matrix  n in
  Stdlib.Printf.printf "Count: %d\n" ans


let ()  =
  solves lines
