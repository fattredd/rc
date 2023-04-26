; Datatype conversions

; Reformatted from https://www.autohotkey.com/boards/viewtopic.php?p=14663#p14663

__str(&arg) {
  Return arg .= ""
}
__flo(&arg, defaultValue:=.0) {
  Return (Type(arg + .0) == "Float"? arg += .0: arg:= defaultValue + .0)
}
__int(&arg, defaultValue:=0) {
 try {
  Goto("__int_" Type(arg + 0)) ;switch
  __int_Integer: ;case Integer
    Return arg += 0
  __int_Float: ;case Float
    Return (arg:= round(arg))
  } catch
    Return arg := defaultValue ;if defaultValue Float or String you will get the same type.
}
