SyntaxHighlight[lang_String, code_String] :=
 Module[{language, template, ba, tokens},
  language = lang /. "WolframLanguage" -> "Mathematica";
  If[
   Head[WolframPython`Sessions`Pygments] =!= ExternalSessionObject,
   WolframPython`Sessions`Pygments = StartExternalSession["Python"]
   ];
  template = StringTemplate["from pygments import highlight
from pygments.lexers import `language`Lexer
from mathematica import MathematicaLexer
from pygments.formatters import RawTokenFormatter
code = '''
`code`
'''
highlight(code, `language`Lexer(), RawTokenFormatter())"];
  ba = ExternalEvaluate[
    Python`PygmentSession,
    TemplateApply[template, <|"code" -> code, "language" -> language|>]
    ];
  tokens = ImportString[ImportByteArray[ba, "String"], "TSV"];
  Row[
   Map[
    Function[{item},
     With[{
       token = First[item],
       string = StringReplace[
         StringReplace[Last[item], {
           "\\n" -> "\n",
           "\\t" -> "\t"}],
         StartOfString ~~ "'" ~~ x__ ~~ "'" ~~ EndOfString :> x]
       },
      Switch[
       token,
       "Token.Text", Style[string, Blue],
       "Token.Text.Whitespace", string,
       "Token.Error", Style[string, Red],
       "Token.Other", Style[string, Pink],
       "Token.Keyword", Style[string, Black, Bold],
       "Token.Keyword.Type", Style[string, Orange],
       "Token.Name", Style[string, Black, Bold],
       "Token.Name.Builtin", Style[string, Purple, Bold],
       "Token.Name.Tag", Style[string, Black, Bold],
       "Token.Name.Function", Style[string, Black],
       "Token.Name.Variable", Style[string, Blue],
       "Token.Name.Variable.Class", Style[string, Brown],
       "Token.Literal", string,
       "Token.Literal.String", Style[string, Darker[Pink]],
       "Token.Literal.String.Single", Style[string, Darker[Orange]],
       "Token.Literal.Number", Style[string, Blue],
       "Token.Literal.Number.Integer", Style[string, Blue],
       "Token.Literal.Number.Float", string,
       "Token.Operator", Style[string, Bold, Darker[Green]],
       "Token.Punctuation", Style[string, Black],
       "Token.Comment", Style[string, Gray],
       "Token.Comment.Single", Style[string, Gray],
       "Token.Generic", string,
       _, Print[token]; Style[string, Red]]
      ]
     ]
    , tokens]]
  ]
