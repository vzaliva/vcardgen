module R = Core_kernel.Result
open Syntax

module Group : sig
  type t 
  val to_string : t -> string option
end = struct
  
  type t = string option
  let to_string g = g
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
end = struct
         
         type t = { 
             name : string;
             values : string list;
           }
       end
        
module Value : sig
  type t
  val to_string : t -> string
end = struct
  
  type t = string
  let to_string t = t 
end

module Content_line = struct

  type t = {
      group : Group.t;
      name : Name.t;
      parameters : Parameter.t list;
      value : Value.t;
    }
end
                        
type t = {
    content_lines : Content_line.t list;
  }
           
