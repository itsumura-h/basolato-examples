import ../value_objects
# include ../../di_container
import repositories/post_rdb_repository

type IPostRepository* = ref object
  rdb: PostRdbRepository


proc newIPostRepository*():IPostRepository =
  return IPostRepository(
    rdb: newPostRepository()
  )

proc store*(this:IPostRepository, userId:UserId,  title:PostTitle, content:PostContent) =
  this.rdb.store(userId, title, content)

proc changeStatus*(this:IPostRepository, id:PostId, status:bool) =
  this.rdb.changeStatus(id, status)

proc destroy*(this:IPostRepository, id:PostId) =
  this.rdb.destroy(id)

proc update*(this:IPostRepository, id:PostId, title:PostTitle, content:PostContent, isFinished:bool) =
  this.rdb.update(id, title, content, isFinished)
