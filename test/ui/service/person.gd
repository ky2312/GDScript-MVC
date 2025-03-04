class_name PersonService extends FrameworkService

var _repository: FrameworkRepository
func _init(repository: FrameworkRepository):
	self._repository = repository
func add_player(name: String, hp: int = 100, atk: int = 10) -> PersonModel:
	var m = PersonModel.new(name)
	m.hp = hp
	m.atk = atk
	m.is_player = true
	return self._repository.add(m)
func add_mob(name: String, hp: int = 50, atk: int = 10) -> PersonModel:
	var m = PersonModel.new(name)
	m.hp = hp
	m.atk = atk
	m.is_player = false
	return self._repository.add(m)
func delete(id: int):
	self._repository.delete(PersonModel.new("").set_id(id))
func query(id: int) -> PersonModel:
	return self._repository.query(PersonModel.new("").set_id(id))
