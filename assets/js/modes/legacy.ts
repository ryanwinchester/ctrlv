import {apl} from "@codemirror/legacy-modes/mode/apl";
import {asciiArmor} from "@codemirror/legacy-modes/mode/asciiarmor";
import {asn1} from "@codemirror/legacy-modes/mode/asn1";
import {asterisk} from "@codemirror/legacy-modes/mode/asterisk";
import {brainfuck} from "@codemirror/legacy-modes/mode/brainfuck";
import {c, csharp, scala, kotlin, objectiveC, dart} from "@codemirror/legacy-modes/mode/clike";
import {clojure} from "@codemirror/legacy-modes/mode/clojure";
import {cmake} from "@codemirror/legacy-modes/mode/cmake";
import {cobol} from "@codemirror/legacy-modes/mode/cobol";
import {coffeeScript} from "@codemirror/legacy-modes/mode/coffeescript";
import {commonLisp} from "@codemirror/legacy-modes/mode/commonlisp";
import {crystal} from "@codemirror/legacy-modes/mode/crystal";
import {sCSS, less} from "@codemirror/legacy-modes/mode/css";
import {cypher} from "@codemirror/legacy-modes/mode/cypher";
import {d} from "@codemirror/legacy-modes/mode/d";
import {diff} from "@codemirror/legacy-modes/mode/diff";
import {dockerFile} from "@codemirror/legacy-modes/mode/dockerfile";
import {dtd} from "@codemirror/legacy-modes/mode/dtd";
import {dylan} from "@codemirror/legacy-modes/mode/dylan";
import {ebnf} from "@codemirror/legacy-modes/mode/ebnf";
import {ecl} from "@codemirror/legacy-modes/mode/ecl";
import {eiffel} from "@codemirror/legacy-modes/mode/eiffel";
import {elm} from "@codemirror/legacy-modes/mode/elm";
import {erlang} from "@codemirror/legacy-modes/mode/erlang";
import {factor} from "@codemirror/legacy-modes/mode/factor";
import {fcl} from "@codemirror/legacy-modes/mode/fcl";
import {forth} from "@codemirror/legacy-modes/mode/forth";
import {fortran} from "@codemirror/legacy-modes/mode/fortran";
import {gas} from "@codemirror/legacy-modes/mode/gas";
import {gherkin} from "@codemirror/legacy-modes/mode/gherkin";
import {go} from "@codemirror/legacy-modes/mode/go";
import {groovy} from "@codemirror/legacy-modes/mode/groovy";
import {haskell} from "@codemirror/legacy-modes/mode/haskell";
import {haxe} from "@codemirror/legacy-modes/mode/haxe";
import {http} from "@codemirror/legacy-modes/mode/http";
import {idl} from "@codemirror/legacy-modes/mode/idl";
import {typescript} from "@codemirror/legacy-modes/mode/javascript";
import {jinja2} from "@codemirror/legacy-modes/mode/jinja2";
import {julia} from "@codemirror/legacy-modes/mode/julia";
import {liveScript} from "@codemirror/legacy-modes/mode/livescript";
import {lua} from "@codemirror/legacy-modes/mode/lua";
import {mathematica} from "@codemirror/legacy-modes/mode/mathematica";
import {mbox} from "@codemirror/legacy-modes/mode/mbox";
import {mirc} from "@codemirror/legacy-modes/mode/mirc";
import {oCaml, fSharp, sml} from "@codemirror/legacy-modes/mode/mllike";
import {modelica} from "@codemirror/legacy-modes/mode/modelica";
import {mscgen} from "@codemirror/legacy-modes/mode/mscgen";
import {mumps} from "@codemirror/legacy-modes/mode/mumps";
import {nginx} from "@codemirror/legacy-modes/mode/nginx";
import {nsis} from "@codemirror/legacy-modes/mode/nsis";
import {ntriples} from "@codemirror/legacy-modes/mode/ntriples";
import {octave} from "@codemirror/legacy-modes/mode/octave";
import {oz} from "@codemirror/legacy-modes/mode/oz";
import {pascal} from "@codemirror/legacy-modes/mode/pascal";
import {perl} from "@codemirror/legacy-modes/mode/perl";
import {pig} from "@codemirror/legacy-modes/mode/pig";
import {powerShell} from "@codemirror/legacy-modes/mode/powershell";
import {properties} from "@codemirror/legacy-modes/mode/properties";
import {protobuf} from "@codemirror/legacy-modes/mode/protobuf";
import {puppet} from "@codemirror/legacy-modes/mode/puppet";
import {q} from "@codemirror/legacy-modes/mode/q";
import {r} from "@codemirror/legacy-modes/mode/r";
import {ruby} from "@codemirror/legacy-modes/mode/ruby";
import {sas} from "@codemirror/legacy-modes/mode/sas";
import {scheme} from "@codemirror/legacy-modes/mode/scheme";
import {shell} from "@codemirror/legacy-modes/mode/shell";
import {sieve} from "@codemirror/legacy-modes/mode/sieve";
import {smalltalk} from "@codemirror/legacy-modes/mode/smalltalk";
import {solr} from "@codemirror/legacy-modes/mode/solr";
import {sparql} from "@codemirror/legacy-modes/mode/sparql";
import {spreadsheet} from "@codemirror/legacy-modes/mode/spreadsheet";
import {sql, msSQL, plSQL} from "@codemirror/legacy-modes/mode/sql";
import {stex} from "@codemirror/legacy-modes/mode/stex";
import {stylus} from "@codemirror/legacy-modes/mode/stylus";
import {swift} from "@codemirror/legacy-modes/mode/swift";
import {tcl} from "@codemirror/legacy-modes/mode/tcl";
import {textile} from "@codemirror/legacy-modes/mode/textile";
import {tiki} from "@codemirror/legacy-modes/mode/tiki";
import {toml} from "@codemirror/legacy-modes/mode/toml";
import {troff} from "@codemirror/legacy-modes/mode/troff";
import {ttcn} from "@codemirror/legacy-modes/mode/ttcn";
import {turtle} from "@codemirror/legacy-modes/mode/turtle";
import {vb} from "@codemirror/legacy-modes/mode/vb";
import {vbScript} from "@codemirror/legacy-modes/mode/vbscript";
import {velocity} from "@codemirror/legacy-modes/mode/velocity";
import {verilog} from "@codemirror/legacy-modes/mode/verilog";
import {vhdl} from "@codemirror/legacy-modes/mode/vhdl";
import {wast} from "@codemirror/legacy-modes/mode/wast";
import {webIDL} from "@codemirror/legacy-modes/mode/webidl";
import {xml} from "@codemirror/legacy-modes/mode/xml";
import {xQuery} from "@codemirror/legacy-modes/mode/xquery";
import {yacas} from "@codemirror/legacy-modes/mode/yacas";
import {yaml} from "@codemirror/legacy-modes/mode/yaml";
import {z80} from "@codemirror/legacy-modes/mode/z80";

export default {
  apl,
  asciiArmor,
  asn1,
  asterisk,
  brainfuck,
  c,
  csharp,
  scala,
  kotlin,
  objectiveC,
  dart,
  clojure,
  cmake,
  cobol,
  coffeeScript,
  commonLisp,
  crystal,
  sCSS, less,
  cypher,
  d,
  diff,
  dockerFile,
  dtd,
  dylan,
  ebnf,
  ecl,
  eiffel,
  elm,
  erlang,
  factor,
  fcl,
  forth,
  fortran,
  gas,
  gherkin,
  go,
  groovy,
  haskell,
  haxe,
  http,
  idl,
  typescript,
  jinja2,
  julia,
  liveScript,
  lua,
  mathematica,
  mbox,
  mirc,
  oCaml,
  fSharp,
  sml,
  modelica,
  mscgen,
  mumps,
  nginx,
  nsis,
  ntriples,
  octave,
  oz,
  pascal,
  perl,
  pig,
  powerShell,
  properties,
  protobuf,
  puppet,
  q,
  r,
  ruby,
  sas,
  scheme,
  shell,
  sieve,
  smalltalk,
  solr,
  sparql,
  spreadsheet,
  sql,
  msSQL,
  plSQL,
  stex,
  stylus,
  swift,
  tcl,
  textile,
  tiki,
  toml,
  troff,
  ttcn,
  turtle,
  vb,
  vbScript,
  velocity,
  verilog,
  vhdl,
  wast,
  webIDL,
  xml,
  xQuery,
  yacas,
  yaml,
  z80,
}
