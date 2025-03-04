class_name Framework

static var is_debug: bool = true

func _init():
	pass

## 把数据转换为字符串
## [["key", "value"], ...] => "key:value, ..."
static func value_to_string(value: Array, sep: String = ", ") -> String:
	return value.reduce(func(to, cur): return to + cur[0] + ":" + str(cur[1]) + sep, "")


#class Observer extends RefCounted:
	#pass

#class Event:
	#pass
