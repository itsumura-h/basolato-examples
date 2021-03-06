import asyncdispatch
import basolato/middleware

proc checkCsrfTokenMiddleware*(r:Request, p:Params):Future[Response] {.async.} =
  let res = await checkCsrfToken(r, p)
  if res.isError:
    raise newException(Error403, res.message)
  return next()

proc checkSessionIdMiddleware*(r:Request, p:Params):Future[Response] {.async.} =
  let res = await checkSessionId(r)
  if res.isError:
    raise newException(ErrorRedirect, "/signin")
  return next()
