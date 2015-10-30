open Vcard_4_0
open Printer
       
let () =
  let open Content_line in
  let c = empty in
  let c1 = append c Group.empty Name.FN [] (Value.from_string "Vadim Zaliva") in
  print stdout c1
        
