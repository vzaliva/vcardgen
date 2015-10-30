open Vcard_4_0
open Printer
       
let () =
  let open Content_line in
  let ( >@ ) a b = append_content_line a b in
  let c = empty
          >@ (content_line Name.FN [] (Value.string_value "Vadim Zaliva"))
          >@ (content_line Name.N [] (Value.string_value "Zaliva; Vadim"))
          >@ (content_line Name.EMAIL [
                             Parameter.parameter "type" "INTERNET";
                             Parameter.parameter "type" "WORK";
                             Parameter.parameter "type" "pref";
                             Parameter.parameter "PREF" "1"
                           ] (Value.string_value "lord@codeminders.com"))
          >@ (content_line Name.EMAIL [
                             Parameter.parameter "type" "INTERNET";
                             Parameter.parameter "type" "HOME";
                           ] (Value.string_value "lord@crocodile.org")) in


  let ic = open_in "botero.jpeg" in
  try 
    let cp = append_photo c ic "JPEG" in
    print stdout cp;
    close_in ic 
  with e -> 
    close_in_noerr ic;
    raise e
  
        
