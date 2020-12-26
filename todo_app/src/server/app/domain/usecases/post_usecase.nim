import json
import ../models/value_objects
import ../models/post/post_repository_interface
import ../query_services/query_service_interface

type PostUsecase* = ref object
  repository: IPostRepository
  queryService: IQueryService

proc newPostUsecase*():PostUsecase =
  return PostUsecase(
    repository: newIPostRepository(),
    queryService: newIQueryService()
  )


proc index*(this:PostUsecase, userId:int):seq[JsonNode] =
  let userId = newUserId(userId)
  return this.queryService.getPosts(userId)

proc show*(this:PostUsecase, id:int):JsonNode =
  let postId = newPostId(id)
  return this.queryService.getPost(postId)

proc store*(this:PostUsecase, userId:int, title, content:string) =
  let userId = newUserId(userId)
  let title = newPostTitle(title)
  let content = newPostContent(content)
  this.repository.store(userId, title, content)

proc changeStatus*(this:PostUsecase, id:int, status:bool) =
  let id = newPostId(id)
  this.repository.changeStatus(id, status)

proc destroy*(this:PostUsecase, id:int) =
  let id = newPostId(id)
  this.repository.destroy(id)

proc update*(this:PostUsecase, id:int, title, content:string, isFinished:bool) =
  let id = newPostId(id)
  let title = newPostTitle(title)
  let content = newPostContent(content)
  this.repository.update(id, title, content, isFinished)
