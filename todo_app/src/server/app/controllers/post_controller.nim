import json, strutils
# framework
import basolato/controller
# domain
import ../domain/usecases/post_usecase
# view
import ../../resources/pages/post/index_view
import ../../resources/pages/post/show_view

proc index*(request:Request, params:Params):Future[Response] {.async.} =
  let auth = await newAuth(request)
  let userId = parseInt(await auth.get("id"))
  let usecase = newPostUsecase()
  let posts = usecase.index(userId)
  return render(await indexView(auth, posts))

proc show*(request:Request, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  let usecase = newPostUsecase()
  let post = usecase.show(id)
  let auth = await newAuth(request)
  return render(await showView(auth, post))

proc store*(request:Request, params:Params):Future[Response] {.async.} =
  let title = params.getStr("title")
  let content = params.getStr("content")
  let auth = await newAuth(request)
  try:
    let userId = await(auth.get("id")).parseInt
    let usecase = newPostUsecase()
    usecase.store(userId, title, content)
    return redirect("/")
  except:
    await auth.setFlash("error", getCurrentExceptionMsg())
    return redirect("/")

proc changeStatus*(request:Request, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  let status = params.getBool("status")
  let usecase = newPostUsecase()
  usecase.changeStatus(id, status)
  return redirect("/")

proc destroy*(request:Request, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  let usecase = newPostUsecase()
  usecase.destroy(id)
  return redirect("/")

proc update*(request:Request, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  let title = params.getStr("title")
  let content = params.getStr("content")
  let isFinished = params.getBool("is_finished")
  let auth = await newAuth(request)
  try:
    let usecase = newPostUsecase()
    usecase.update(id, title, content, isFinished)
    return redirect("/")
  except:
    await auth.setFlash("error", getCurrentExceptionMsg())
    let post = %*{"title": title, "content": content, "is_finished": isFinished}
    return render(await showView(auth, post))
