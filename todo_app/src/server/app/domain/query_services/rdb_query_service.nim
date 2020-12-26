import json
import allographer/query_builder
import ../models/value_objects

type RdbQueryService* = ref object

proc newRdbQueryService*(): RdbQueryService =
  return RdbQueryService()

proc getUser*(this:RdbQueryService, email:UserEmail):JsonNode =
  return rdb().table("users").where("email", "=", email.get).first()

proc getPosts*(this:RdbQueryService, userId:UserId):seq[JsonNode] =
  return rdb().table("posts")
        .select("posts.id", "title", "content", "is_finished")
        .join("users", "users.id", "=", "posts.user_id")
        .where("users.id", "=", userId.get)
        .get()

proc getPost*(this:RdbQueryService, id:PostId):JsonNode =
  return rdb().table("posts").find(id.get)
