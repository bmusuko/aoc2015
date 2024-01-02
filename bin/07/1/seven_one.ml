(* open Core

let read_lines filename =
  try
    In_channel.read_lines filename
  with
  | Sys_error msg -> failwith ("Could not open file: " ^ msg)
  | End_of_file -> failwith "Unexpected end of file"

let file = "../data/test.txt"
let lines = read_lines file

let get_val map key  =
  match Map.find map key with
  | Some value -> value
  | None -> failwith "Key not found"
  
let get_val_or_int map x =
  match int_of_string_opt x with
  | Some value -> value
  | None -> get_val map x

let get_x_and_y line map =
  match
    Scanf.sscanf line "%s %s %s -> %s" (fun x operation y target ->
        (x, operation, y, target))
  with
  | x, operation, y, target ->
      let x_val = get_val_or_int map x in
      let y_val = get_val_or_int map y in
      x_val, y_val, target, operation


let generate_value x y operation = 
  match operation with
  | "AND"    -> x land y
  | "OR"     -> x lor y
  | "RSHIFT" -> x lsr y
  | "LSHIFT" -> x lsl y
  | _        -> failwith "invalid operation"

  let solve line map =
    match String.split ~on:' ' line with
    | _ :: "AND" :: _
    | _ :: "OR" :: _
    | _ :: "RSHIFT" :: _
    | _ :: "LSHIFT" :: _ ->
        let x, y, target, operation = get_x_and_y line map in
        let value = generate_value x y operation in
        Map.add_exn map ~key:target ~data:value
    | "NOT" :: x_val :: _ :: target :: _ ->
        let x = get_val_or_int map x_val in
        let value = lnot x in
        Map.add_exn map ~key:target ~data:value
    | x_val :: _ :: target :: _ ->
        let x = get_val_or_int map x_val in
        Map.add_exn map ~key:target ~data:x
    | _ -> failwith "Incorrect operation"

    
let solves lines =
  let map = ref (Core.String.Map.empty) in
  Stdlib.List.iter (fun line ->  map := solve line !map) lines;
  let final_map = !map in
  Printf.printf "Count: %d\n" (get_val final_map "i")
    
let () = solves lines *)

open Core

let read_lines filename =
  try
    In_channel.read_lines filename
  with
  | Sys_error msg -> failwith ("Could not open file: " ^ msg)
  | End_of_file -> failwith "Unexpected end of file"

let file = "../data/test.txt"
let lines = read_lines file

let get_val map key  =
  match Map.find map key with
  | Some value -> value
  | None -> failwith "Key not found"
  
let get_val_or_int64 map x =
  match Int64.of_string_opt x with
  | Some value -> value
  | None -> Int64.of_int (get_val map x)

let get_x_and_y line map =
  match
    Scanf.sscanf line "%s %s %s -> %s" (fun x operation y target ->
        (x, operation, y, target))
  with
  | x, operation, y, target ->
      let x_val = get_val_or_int64 map x in
      let y_val = get_val_or_int64 map y in
      x_val, y_val, target, operation

let generate_value x y operation = 
  match operation with
  | "AND"    -> Int64.(land) x y
  | "OR"     -> Int64.(lor) x y
  | "RSHIFT" -> Int64.shift_right_logical x (Int64.to_int_exn y)
  | "LSHIFT" -> Int64.shift_left x (Int64.to_int_exn y)
  | _        -> failwith "invalid operation"

  let solve line map =
    match String.split ~on:' ' line with
    | _ :: "AND" :: _
    | _ :: "OR" :: _
    | _ :: "RSHIFT" :: _
    | _ :: "LSHIFT" :: _ ->
        let x, y, target, operation = get_x_and_y line map in
        let value = generate_value x y operation in
        Map.add_exn map ~key:target ~data:value
    | "NOT" :: x_val :: _ :: target :: _ ->
        let x = get_val_or_int64 map x_val in
        let value = Int64.lnot x in
        Map.add_exn map ~key:target ~data:value
    | x_val :: _ :: target :: _ ->
        let x = get_val_or_int64 map x_val in
        Map.add_exn map ~key:target ~data:x
    | _ -> failwith "Incorrect operation"
  

let solves lines =
  let map = ref (Core.String.Map.empty) in

  (* Set a key-value pair *)
  let key = "test_key" in
  let value = 42L in  (* Assuming the value is of type int64 *)
  map := Map.add_exn !map ~key ~data:value;

  Stdlib.List.iter (fun line ->  map := solve line !map) lines;
  let final_map = !map in
  Printf.printf "Count: %Ld\n" (get_val final_map "i")

let () = solves lines
