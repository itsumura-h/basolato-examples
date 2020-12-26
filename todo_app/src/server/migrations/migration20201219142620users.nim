import json, strformat, times
import allographer/schema_builder
import allographer/query_builder
import basolato/password

proc migration20201219142620users*() =
  schema(
    table("users", [
      Column().increments("id"),
      Column().string("name"),
      Column().string("email"),
      Column().string("password"),
      Column().timestamps()
    ])
  )

  # Seeder
  if rdb().table("users").count() == 0:
    var users: seq[JsonNode]
    for i in 1..10:
      users.add(%*{
        "id": i,
        "name": &"user{i}",
        "email": &"user{i}@nim.com",
        "password": genHashedPassword(&"Password{i}"),
        "created_at": $(now().utc),
        "updated_at": $(now().utc),
      })
    rdb().table("users").insert(users)
