import models/user/repositories/user_rdb_repository
import models/post/repositories/post_rdb_repository
import query_services/rdb_query_service

type DiContainer* = tuple
  userRdbRepository: UserRdbRepository
  postRdbRepository: PostRdbRepository
  queryService: RdbQueryService
