@module("date-fns") external format: (Js.Date.t, string) => string = "format"
@module("date-fns") external isToday: Js.Date.t => bool = "isToday"
@module("date-fns") external isYesterday: Js.Date.t => bool = "isYesterday"
