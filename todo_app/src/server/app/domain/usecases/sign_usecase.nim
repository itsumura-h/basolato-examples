import json
import ../models/value_objects
import ../models/user/user_repository_interface
import ../models/user/user_service
import ../query_services/query_service_interface


type SignUsecase* = ref object
  repository: IUserRepository
  service: UserService
  queryService: IQueryService

proc newSignUsecase*():SignUsecase =
  return SignUsecase(
    repository: newIUserRepository(),
    service: newUserService(),
    queryService: newIQueryService()
  )


proc signUp*(this:SignUsecase, name, email, password:string):JsonNode =
  let name = newUserName(name)
  let email = newUserEmail(email)
  let password = newPassword(password).getHashed()
  let userId = this.repository.storeUser(name, email, password)
  return %*{"id": userId.get, "name": name}

proc signIn*(this:SignUsecase, email, password:string):JsonNode =
  let email = newUserEmail(email)
  let user = this.queryService.getUser(email)
  let password = newPassword(password)
  let hashedPassword = newHashedPassword(user["password"].getStr)
  if this.service.isMatchPassword(password, hashedPassword):
    return %*{"id": user["id"].getInt, "name": user["name"].getStr}
  else:
    raise newException(Exception, "password not match")
