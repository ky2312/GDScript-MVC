class_name PersonModel extends FrameworkModel

var username: String
var is_player: bool = false
var hp: float
var atk: float
func _init(username: String):
	self.username = username
func table_name(): 
	return "person"
func _to_string() -> String:
	return super._to_string() + Framework.value_to_string([
		["username", self.username],
		["is_player", self.is_player],
		["hp", self.hp],
		["atk", self.atk],
	])
