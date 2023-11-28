(*
   File Handling
*)

let read_lines (file_name : string) : string list =
  let chan = open_in file_name in
  let rec read_lines (chan : in_channel) : string list =
    try
      let line = input_line chan in
      line :: read_lines chan
    with
    | End_of_file -> []
  in
  let lines = read_lines chan in
  close_in chan;
  lines

(* reading bytes directly would be more efficient *)
let read_file (file_name : string) : string =
  read_lines file_name |> String.concat "\n"



(*
   String Manipulation

   Scanf:
   Similar to Printf, there is Scanf.
   You can use it to simple extract data from a string.
   Example Scanf.scanff string "%s = %d" (fun name int_val -> ...)

   Str:
   For medium-complexity parsing, Str is helpful.
   Str.string_match matches a pattern (created by Str.regexp {|...|})
   and can be extracted using Str.matched_group.
   For large applications, use https://github.com/ocaml/ocaml-re.
   For complex parsing, use mehir or write a custom parsing.

*)

let explode (s : string) : char list = String.to_seq s |> List.of_seq
let implode (cs : char list) : string = List.to_seq cs |> String.of_seq

let get_all_matches regexp s =
  let rec aux i =
    try
    let m = Str.search_forward regexp s i in
    let ms = Str.matched_group 0 s in
    ms :: aux (m + String.length ms)
    with Not_found -> []
  in
  aux 0

let split (splitter:string) s =
  let len = String.length splitter in
  if len = 0 then failwith "split: empty splitter"
  else
    let rec aux i =
      try
        let m = String.index_from s i splitter.[0] in
        if String.sub s m len = splitter then
          String.sub s i (m-i) :: aux (m+len)
        else aux (m+1)
      with Not_found -> [String.sub s i (String.length s - i)]
    in
    aux 0

(* to give the output *)
let dump i res =
  Printf.printf "Part %d: %s\n%!" i res
let dump_int i res =
  dump i (string_of_int res)

let time f x =
  let t = Sys.time () in
  let fx = Sys. opaque_identity (f x) in
  let time = Sys.time () -. t in
  Printf.printf "Execution time: %fs\n%!" time;
  fx



(*
   General Combinators
*)

let rec first f k = if f k then k else first f (k+1)
let rec iter f n x = if n < 1 then x else iter f (n-1) (f x)

(* applies f until p holds *)
let rec repeat p f x =
  if p x then x else repeat p f (f x)

let repeatUntil = repeat
let repeatWhile p = repeat (fun x -> not (p x))

(* wrap a function to only compute once on an input *)
let memo f =
  let cache = Hashtbl.create 10000 in
  fun x ->
    try Hashtbl.find cache x
    with Not_found ->
      let y = f x in
      Hashtbl.add cache x y;
      y

(* recursive closure with lists instead of hashtable *)
let memo_rec f =
  let m = ref [] in
  let rec g x =
    try
      List.assoc x !m
    with
    Not_found ->
      let y = f g x in
        m := (x, y) :: !m ;
        y
  in
    g


(*
   List Combinators

   If you do not need to change the size, do not need immutability
   (older versions are not needed -- can be overwritten), and want
   fast lookup, you can use Arrays.
   Use Array. instead of List. (of_list and to_list are helpful).
   You can access and write using 
   arr.(idx) and arr.(k) <- new_value
*)

(* splits a list where p holds *)
let group_by ?(keep=false) p xs : 'a list list =
  let rec aux g xs =
    match xs with
    | [] -> if g = [] then [] else [List.rev g]
    | x :: xs ->
      if p x then (List.rev g)::aux (if keep then [x] else []) xs
      else aux (x::g) xs
  in
  aux [] xs

let rec take n = function
  | x :: xs when n > 0 -> x :: take (n - 1) xs
  | _ -> []

let rec drop n = function
  | _ :: xs when n > 0 -> drop (n - 1) xs
  | xs -> xs

let rec takeDrop n = function
  | x :: xs when n > 0 ->
    let (xs', xs'') = takeDrop (n - 1) xs in
    (x :: xs', xs'')
  | xs -> ([], xs)
