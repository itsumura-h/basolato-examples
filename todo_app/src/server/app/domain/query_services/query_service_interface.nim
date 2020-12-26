import json
# include ../di_container
import rdb_query_service
import ../models/value_objects

type IQueryService* = ref object
  rdb: RdbQueryService

proc newIQueryService*():IQueryService =
  return IQueryService(
    rdb: newRdbQueryService()
  )


proc getUser*(this:IQueryService, email:UserEmail):JsonNode =
  return this.rdb.getUser(email)

proc getPosts*(this:IQueryService, userId:UserId):seq[JsonNode] =
  return this.rdb.getPosts(userId)

proc getPost*(this:IQueryService, postId:PostId):JsonNode =
  return this.rdb.getPost(postId)
