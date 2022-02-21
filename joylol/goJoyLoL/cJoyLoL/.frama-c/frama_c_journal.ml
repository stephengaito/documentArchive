(* Frama-C journal generated at 15:41 the 21/08/2020 *)

exception Unreachable
exception Exception of string

[@@@ warning "-26"]

(* Run the user commands *)
let run () =
  Dynamic.Parameter.Bool.set "-wp" true;
  Dynamic.Parameter.Bool.set "-rte" true;
  Dynamic.Parameter.String.set "" "/home/dev/goJoyLoL/cJoyLoL/joylol.c";
  File.init_from_cmdline ();
  !Db.RteGen.compute ();
  Dynamic.Parameter.Bool.clear "-wp" ();
  Project.set_keep_current false;
  Dynamic.Parameter.String.set "-wp-cache" "none";
  ()

(* Main *)
let main () =
  Journal.keep_file ".frama-c/frama_c_journal.ml";
  try run ()
  with
  | Unreachable -> Kernel.fatal "Journal reaches an assumed dead code" 
  | Exception s -> Kernel.log "Journal re-raised the exception %S" s
  | exn ->
    Kernel.fatal
      "Journal raised an unexpected exception: %s"
      (Printexc.to_string exn)

(* Registering *)
let main : unit -> unit =
  Dynamic.register
    ~plugin:"Frama_c_journal.ml"
    "main"
    (Datatype.func Datatype.unit Datatype.unit)
    ~journalize:false
    main

(* Hooking *)
let () = Cmdline.run_after_loading_stage main; Cmdline.is_going_to_load ()
