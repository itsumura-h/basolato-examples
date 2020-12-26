import asyncdispatch
import basolato/middleware

proc checkCsrfTokenMiddleware*(r:Request, p:Params) {.async.} =
  let res = await checkCsrfToken(r, p)
  if res.isError:
    raise newException(Error403, res.message)

proc chrckAuthTokenMiddleware*(r:Request, p:Params) {.async.} =
  let res = await checkAuthToken(r)
  if res.isError:
    raise newException(ErrorRedirect, "/signin")
