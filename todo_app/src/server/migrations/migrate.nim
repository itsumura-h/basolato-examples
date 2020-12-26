import migration20201219142620users
import migration20201219142632posts

proc main() =
  migration20201219142620users()
  migration20201219142632posts()

main()
