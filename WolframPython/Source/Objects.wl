PythonObject[session_ExternalSessionObject, name_String] := Module[{},
  ExternalEvaluate[session,
    TemplateApply[
      StringTemplate["{ 'name' : '`name`', '__module__' : type(`name`).__module__, '__name__' : type(`name`).__name__, 'id' : id(`name`) }"],
      <|"name" -> name|>
    ]
  ]
]

PythonObjectEvaluate[session_, object_Association, code_String] := Module[{},
  Once[ExternalEvaluate[session,"import ctypes"]];
  ExternalEvaluate[
    session,
    TemplateApply[
      StringTemplate["ctypes.cast(`id`,ctypes.py_object).value.`code`"],
      <|"id" -> object["id"], "code" -> code|>
    ]
  ]
]
