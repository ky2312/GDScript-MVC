## 仓库类
## 管理数据存储
class_name FrameworkRepository extends RefCounted

func ready_data(model: FrameworkModel, f: Callable) -> FrameworkModel:
	if not self._check_table_name(model):
		return
	f.call()
	return model
func print_info(method_name: String, model: FrameworkModel):
	if Framework.is_debug:
		print("MemoryRepository %s: %s" % [method_name, JSON.stringify(model)])
func _check_table_name(model: FrameworkModel) -> bool:
	var table_name = model.table_name()
	if table_name.is_empty():
		FrameworkError.new("model没有table_name %s" % [model]).throw()
		return false
	return true

## 内存仓库类
class MemoryFrameworkRepository extends FrameworkRepository:
	static var _data = {}
	func add(model: FrameworkModel) -> FrameworkModel:
		return self.ready_data(model, func():
			var table_name = model.table_name()
			var table = MemoryFrameworkRepository._data.get_or_add(table_name, {})
			model.id = len(table) + 1
			table.set(model.id, model)
			self.print_info("add", model)
		)
	func delete(model: FrameworkModel) -> FrameworkModel:
		return self.ready_data(model, func():
			var table_name = model.table_name()
			var table = MemoryFrameworkRepository._data.get(table_name)
			if not table or not table.erase(model.id):
				return
			self.print_info("delete", model)
		)
	func query(model: FrameworkModel) -> FrameworkModel:
		return self.ready_data(model, func():
			var table_name = model.table_name()
			var table = MemoryFrameworkRepository._data.get(table_name)
			if not table:
				return
			model = table.get(model.id)
			self.print_info("query", model)
		)
	func update(model: FrameworkModel) -> FrameworkModel:
		return self.ready_data(model, func():
			var table_name = model.table_name()
			var table = MemoryFrameworkRepository._data.get(table_name)
			if not table:
				return
			table.set(model.id, model)
			self.print_info("update", model)
		)
