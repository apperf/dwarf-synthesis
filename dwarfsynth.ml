(** dwarfsynth
 *
 * Entry point for the BAP plugin `dwarfsynth`, defining the command line
 * interface
 **)

module Self = struct
  include Bap.Std.Self()
end

let main = DwarfSynth.Main.main

module Cmdline = struct
  module Cnf = Self.Config

  let outfile = Cnf.(
      param (some string) "output"
        ~doc:("The file in which the output ELF will be written. Output goes "
              ^ "to stdout by default.")
    )

  let () = Cnf.(
      when_ready ((fun {get=(!!)} ->
          Bap.Std.Project.register_pass' (main !!outfile)))
    )
end