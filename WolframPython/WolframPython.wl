BeginPackage["WolframPython`"]

SyntaxHighlight::usage = "SyntaxHighlight[language,code] highlights 'code' string for 'language' using 'pygments'"

Begin["`Private`"]

Get[ FileNameJoin[{DirectoryName[$InputFileName], "Source", "Pygments.wl"}] ];

End[]

EndPackage[]
