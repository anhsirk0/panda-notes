type t

@new external new: string => t = "URLSearchParams"

@send external set: (t, string, string) => unit = "set"
@send external get: (t, string) => string = "get"
