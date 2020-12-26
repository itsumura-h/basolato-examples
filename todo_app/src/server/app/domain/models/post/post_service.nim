import ../value_objects
import post_entity
import post_repository_interface


type postservice* = ref object
  repository:IPostRepository


proc newpostservice*():postservice =
  return postservice(
    repository:newIPostRepository()
  )
