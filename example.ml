open Vcard_4_0
open Printer
       
let () =
  let open Content_line in
  let c0 = empty in
  let c1 = append c0 Group.empty_group Name.FN [] (Value.string_value "Vadim Zaliva") in
  let c2 = append c1 Group.empty_group Name.N [] (Value.string_value "Zaliva; Vadim") in
  let c3 = append c2 Group.empty_group Name.EMAIL [
                    Parameter.parameter "type" "INTERNET";
                    Parameter.parameter "type" "WORK";
                    Parameter.parameter "type" "pref";
                    Parameter.parameter "PREF" "1"
                  ] (Value.string_value "lord@codeminders.com") in
  let c4 = append c3 Group.empty_group Name.EMAIL [
                    Parameter.parameter "type" "INTERNET";
                    Parameter.parameter "type" "HOME";
                  ] (Value.string_value "lord@crocodile.org") in
  print stdout c4
        
