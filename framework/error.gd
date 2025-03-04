class_name FrameworkError extends  RefCounted

enum ErrorStatus {
	## 内部错误
	inner = 1,
	## 视图错误
	view = 2,
}

var message: String

var code: ErrorStatus

var _is_throwed: bool = false

func _init(message: String, code: ErrorStatus = ErrorStatus.inner):
	self.message = message
	self.code = code

func throw():
	if self._is_throwed:
		return
	self._is_throwed = true
	push_error(Framework.value_to_string([
		[self.code, self.message],
	]), " ")
