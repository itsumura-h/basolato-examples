import json, strformat, times
import allographer/schema_builder
import allographer/query_builder

proc migration20201219142632posts*() =
  schema(
    table("posts", [
      Column().increments("id"),
      Column().string("title"),
      Column().text("content"),
      Column().boolean("is_finished"),
      Column().timestamps(),
      Column().foreign("user_id").reference("id").on("users").onDelete(CASCADE)
    ])
  )

  # if rdb().table("posts").count() == 0:
  #   var posts: seq[JsonNode]
  #   posts.add(%*{
  #     "id": 1,
  #     "title": "test",
  #     "content": "test content",
  #     "is_finished": false,
  #     "created_at": $(now().utc),
  #     "updated_at": $(now().utc),
  #     "user_id": 1
  #   })
  #   rdb().table("posts").insert(posts)
