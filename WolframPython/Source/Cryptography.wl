Fernet["GenerateKey"] := Module[{key},
  If[
   Head[WolframPython`Sessions`Cryptography] =!= ExternalSessionObject,
   WolframPython`Sessions`Cryptography = StartExternalSession["Python"]
   ];
   key=ExternalEvaluate[WolframPython`Sessions`Cryptography,"from cryptography.fernet import Fernet
Fernet.generate_key()"];
  key
  ]

Fernet["Encrypt", key_String, message_String] := Module[{template, result},
  template = StringTemplate["f=Fernet(b'`key`')
token=f.encrypt(b'`message`')
token"];
  result = ExternalEvaluate[
    WolframPython`Sessions`Cryptography,
    TemplateApply[template, <|"key" -> key, "message" -> message|>]
  ];
  ImportByteArray[result]
]

Fernet["Decrypt", key_String, message_String] := Module[{template, result},
  template = StringTemplate["f=Fernet(b'`key`')
token=f.decrypt(b'`message`')
token"];
  result = ExternalEvaluate[
     WolframPython`Sessions`Cryptography,
     TemplateApply[template, <|"key" -> key, "message" -> message|>]
  ];
  ImportByteArray[result]
]
