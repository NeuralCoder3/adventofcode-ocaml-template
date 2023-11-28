open Utils

let data = 
  "inputs/0_1.txt"
  |> read_lines
  |> List.map int_of_string

let () =
  data
  |> List.fold_left (+) 0
  |> dump_int 1