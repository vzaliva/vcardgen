open Vcard_4_0
open Printer
       
let () =
  let open Content_line in
  let c = [
      {
        group = Group.empty_group;
        name = Name.FN;
        parameters = [];
        value = Value.value "Vadim Zaliva";
      }
    ]
  in
  print stdout {content_lines=c}
        
