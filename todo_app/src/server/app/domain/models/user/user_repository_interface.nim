import ../value_objects
# include ../../di_container
import repositories/user_rdb_repository
import ./user_entity

type IUserRepository* = ref object
  rdbRepository: UserRdbRepository


proc newIUserRepository*():IUserRepository =
  return IUserRepository()

proc storeUser*(this:IUserRepository,
  name:UserName,
  email:UserEmail,
  hashedPassword:HashedPassword
):UserId =
  return this.rdbRepository.storeUser(name, email, hashedPassword)

proc getUser*(this:IUserRepository, email:UserEmail):User =
  return this.rdbRepository.getUser(email)
