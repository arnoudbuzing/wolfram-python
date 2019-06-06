PythonObject[session_ExternalSessionObject, name_String] := Module[{},
  ExternalEvaluate[session,
    TemplateApply[
      StringTemplate["{ 'name' : '`name`', '__module__' : type(`name`).__module__, '__name__' : type(`name`).__name__, 'id' : id(`name`) }"],
      <|"name" -> name|>
    ]
  ]
]

PythonObjectEvaluate[session_, object_Association, code_String] := Module[{},
  ExternalEvaluate[
    session,
    TemplateApply[
      StringTemplate["`name``.`code`"],
      <|"name" -> object["name"], "code" -> code|>
    ]
  ]
]
