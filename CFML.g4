grammar CFML;

cfm : line* ;

line :
  tagSet
  | tagAbort ;

tagSet : TS 'set' IDENTIFIER EQUALS expression TE ;
tagAbort : TS 'abort' TE ;

TS : '<cf' ; // Tag Start
TE : '>' ; // Tag End

expression : literal ; // TODO

literal : BOOLEAN_LITERAL | STRING_LITERAL ;

EQUALS : '=' ;

BOOLEAN_LITERAL : 'TRUE' | 'FALSE' | 'true' | 'false' ;

STRING_LITERAL
  : '"' DoubleStringCharacter* '"'
  | '\'' SingleStringCharacter* '\''
  ;

fragment DoubleStringCharacter
  : ~('"')
  | '""'
  ;

fragment SingleStringCharacter
  : ~('\'')
  | '\'\''
  ;

fragment LETTER
  : '\u0024'
  | '\u0041'..'\u005a'
  | '\u005f'
  | '\u0061'..'\u007a'
  | '\u00c0'..'\u00d6'
  | '\u00d8'..'\u00f6'
  | '\u00f8'..'\u00ff'
  | '\u0100'..'\u1fff'
  | '\u3040'..'\u318f'
  | '\u3300'..'\u337f'
  | '\u3400'..'\u3d2d'
  | '\u4e00'..'\u9fff'
  | '\uf900'..'\ufaff' ;


fragment DIGIT
  : '\u0030'..'\u0039'
  | '\u0660'..'\u0669'
  | '\u06f0'..'\u06f9'
  | '\u0966'..'\u096f'
  | '\u09e6'..'\u09ef'
  | '\u0a66'..'\u0a6f'
  | '\u0ae6'..'\u0aef'
  | '\u0b66'..'\u0b6f'
  | '\u0be7'..'\u0bef'
  | '\u0c66'..'\u0c6f'
  | '\u0ce6'..'\u0cef'
  | '\u0d66'..'\u0d6f'
  | '\u0e50'..'\u0e59'
  | '\u0ed0'..'\u0ed9'
  | '\u1040'..'\u1049' ;

/* The identifier token should have lower precedence than tokens for
operators and reserved words, so it appears later in the grammar. */
IDENTIFIER : LETTER (LETTER|DIGIT)* ;

WS : [ \t\r\n\f]+ -> skip ; // skip spaces, tabs, newlines, and formfeeds