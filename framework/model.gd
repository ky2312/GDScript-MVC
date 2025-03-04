## 模型类
## 管理数据
class_name FrameworkModel extends RefCounted
	
var id: int

func table_name() -> String:
	return ""

func set_id(id: int):
	self.id = id
	return self

func _to_string() -> String:
	return Framework.value_to_string([
		["table_name", self.table_name()],
		["id", self.id],
	])
