class_name ActionService extends FrameworkService

var _repository: FrameworkRepository
func _init(repository: FrameworkRepository):
	self._repository = repository
## 攻击
func attack(from_id: int, to_id: int):
	var p1 = self._repository.query(PersonModel.new("").set_id(from_id))
	var p2 = self._repository.query(PersonModel.new("").set_id(to_id))
	p2.hp -= p1.atk
	self._repository.update(p2)
## 回复
func cure(id: int, hp: float):
	var p = self._repository.query(PersonModel.new("").set_id(id))
	p.hp += hp
	self._repository.update(p)
