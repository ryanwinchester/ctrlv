defmodule Ctrlv.Pastes.Language do
  @moduledoc """
  The languages supported by <ctrlv.io>.
  """

  @supported_languages ~w(
    cpp css html java javascript json markdown php python rust apl asciiArmor
    asn1 asterisk brainfuck c csharp dart clojure cmake cobol coffeeScript
    commonLisp crystal sCSS less cypher d diff dockerFile dtd dylan ebnf ecl
    eiffel elixir elm erlang factor fcl forth fortran fSharp gas gherkin go
    groovy haskell haxe http idl kotlin jinja2 julia liveScript lua mathematica
    mbox mirc msSQL oCaml plSQL sml modelica mscgen mumps nginx nsis ntriples
    objectiveC octave oz pascal perl pig powerShell properties protobuf puppet
    q r ruby sas scala scheme shell sieve smalltalk solr sparql spreadsheet sql
    stex stylus swift tcl textile tiki toml troff ttcn turtle typescript vb
    vbScript velocity verilog vhdl wast webIDL xml xQuery yacas yaml z80
  )a

  def list, do: @supported_languages
end
