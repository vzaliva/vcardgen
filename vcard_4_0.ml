
module Group : sig
  type t 
  val to_string : t -> string option
  val empty_group : t
  val group : string -> t
end = struct
  
  type t = string option
  let to_string g = g
  let empty_group = None
  let group s = Some s
end

module Name : sig
  type t =
    | SOURCE | KIND | FN | N | NICKNAME | PHOTO | BDAY | ANNIVERSARY | GENDER | ADR 
    | TEL | EMAIL | IMPP | LANG | TZ | GEO | TITLE | ROLE | LOGO | ORG | MEMBER 
    | RELATED | CATEGORIES | NOTE | PRODID | REV | SOUND | UID | CLIENTPIDMAP
    | URL | KEY | FBURL | CALADRURI | CALURI | XML | BIRTHPLACE | DEATHPLACE
    | DEATHDATE | EXPERTISE | HOBBY | INTEREST | ORG_DIRECTORY | X_NAME of string
  val to_string : t -> string
end = struct
  
  type t =
    | SOURCE | KIND | FN | N | NICKNAME | PHOTO | BDAY | ANNIVERSARY | GENDER | ADR 
    | TEL | EMAIL | IMPP | LANG | TZ | GEO | TITLE | ROLE | LOGO | ORG | MEMBER 
    | RELATED | CATEGORIES | NOTE | PRODID | REV | SOUND | UID | CLIENTPIDMAP
    | URL | KEY | FBURL | CALADRURI | CALURI | XML | BIRTHPLACE | DEATHPLACE
    | DEATHDATE | EXPERTISE | HOBBY | INTEREST | ORG_DIRECTORY | X_NAME of string
                                                                             
  let to_string = function
    |SOURCE -> "SOURCE" | KIND -> "KIND" | FN -> "FN" | N -> "N" | NICKNAME -> "NICKNAME" 
    | PHOTO -> "PHOTO" | BDAY -> "BDAY" | ANNIVERSARY -> "ANNIVERSARY" | GENDER -> "GENDER" 
    | ADR  -> "ADR" | TEL -> "TEL" | EMAIL -> "EMAIL" | IMPP -> "IMPP" | LANG -> "LANG" 
    | TZ -> "TZ" | GEO -> "GEO" | TITLE -> "TITLE" | ROLE -> "ROLE" | LOGO -> "LOGO" | ORG -> "ORG" 
    | MEMBER -> "MEMBER" | RELATED -> "RELATED" | CATEGORIES -> "CATEGORIES" | NOTE -> "NOTE"
    | PRODID -> "PRODID" | REV -> "REV" | SOUND -> "SOUND" | UID -> "UID" 
    | CLIENTPIDMAP -> "CLIENTPIDMAP" | URL -> "URL" | KEY -> "KEY" | FBURL -> "FBURL" 
    | CALADRURI -> "CALADRURI" | CALURI -> "CALURI" | XML -> "XML" | BIRTHPLACE -> "BIRTHPLACE"
    | DEATHPLACE -> "DEATHPLACE" | DEATHDATE -> "DEATHDATE" | EXPERTISE -> "EXPERTISE" 
    | HOBBY -> "HOBBY" | INTEREST -> "INTEREST" | ORG_DIRECTORY -> "ORG_DIRECTORY" | X_NAME xname -> xname
                                                                                                       
end

module Parameter : sig
  type t = { 
      name : string;
      values : string list;
    }
  val parameter : string -> string -> t
  val parameters : string -> string list -> t
end = struct
         type t = { 
             name : string;
             values : string list;
           }

         let parameter name value = {name=name; values=[value]}
         let parameters name values = {name=name; values=values}
       end
        
module Value : sig
  type t
  val to_string : t -> string
  val string_value : string -> t
end = struct
  
  type t = string
  let to_string t = t
  let string_value s = s
end

module Content_line = struct
  type t = {
      group : Group.t;
      name : Name.t;
      parameters : Parameter.t list;
      value : Value.t;
    }
  let content_line ?group:(group=Group.empty_group) name parameters value =
    {
      group = group;
      name = name;
      parameters = parameters;
      value = value
    }
end
                        
type t = {
    content_lines : Content_line.t list;
  }
           
let empty : t = {content_lines = [] }

let append_content_line vcard line =
  { content_lines = List.append vcard.content_lines [line] }

let append vcard ?group:(group=Group.empty_group) name parameters value =
  append_content_line vcard
    (Content_line.content_line ~group:group name parameters value)

(* convenience functions to add photo field *)
    
let append_photo vcard ?group:(group=Group.empty_group) data ptype =
  append vcard ~group:group Name.PHOTO [
           Parameter.parameter "type" ptype;
           Parameter.parameter "ENCODING" "b";
         ] (Value.string_value data)
         
let append_photo_from_file vcard ?group:(group=Group.empty_group) filename ptype =
  let open Batteries in
  let ic = open_in filename in
  try
    let data = IO.read_all ic in
    let b64data = Base64.str_encode data in
    append_photo vcard ~group:group b64data ptype
  with e -> 
    close_in_noerr ic;
    raise e

