extends Node2D

func test_data() -> void:
	print("测试数据开始")
	var framework = Framework.new()
	var repository = FrameworkRepository.MemoryFrameworkRepository.new()
	var personService = PersonService.new(repository)
	var actionService = ActionService.new(repository)
	
	var step = [0]
	var player = []
	var mobs: Array[int] = []
	var arr: Array
	
	# 创建玩家和怪物
	player.append(personService.add_player("玩家1", 100, 10).id)
	mobs.append(personService.add_mob("BOSS怪物1", 100, 10).id)
	mobs.append(personService.add_mob("普通怪物1", 50, 10).id)
	
	arr = [
		[personService.query(player[0]), [["username", "玩家1"], ["hp", 100], ["atk", 10]]],
		[personService.query(mobs[0]), [["username", "BOSS怪物1"], ["hp", 100], ["atk", 10]]],
		[personService.query(mobs[1]), [["username", "普通怪物1"], ["hp", 50], ["atk", 10]]],
	]
	for v in arr:
		for sv in v[1]:
			assert(v[0].get(sv[0]) == sv[1])
			
	# 玩家攻击所有怪物
	for mob in mobs:
		actionService.attack(player[0], mob)
	
	arr = [
		[personService.query(player[0]), [["username", "玩家1"], ["hp", 100], ["atk", 10]]],
		[personService.query(mobs[0]), [["username", "BOSS怪物1"], ["hp", 90], ["atk", 10]]],
		[personService.query(mobs[1]), [["username", "普通怪物1"], ["hp", 40], ["atk", 10]]],
	]
	for v in arr:
		for sv in v[1]:
			assert(v[0].get(sv[0]) == sv[1])
		
	# 所有怪物攻击玩家
	for mob in mobs:
		actionService.attack(mob, player[0])
		
	arr = [
		[personService.query(player[0]), [["username", "玩家1"], ["hp", 80], ["atk", 10]]],
		[personService.query(mobs[0]), [["username", "BOSS怪物1"], ["hp", 90], ["atk", 10]]],
		[personService.query(mobs[1]), [["username", "普通怪物1"], ["hp", 40], ["atk", 10]]],
	]
	for v in arr:
		for sv in v[1]:
			assert(v[0].get(sv[0]) == sv[1])
			
	# 玩家被治疗
	actionService.cure(player[0], 100)
	
	arr = [
		[personService.query(player[0]), [["username", "玩家1"], ["hp", 180], ["atk", 10]]],
		[personService.query(mobs[0]), [["username", "BOSS怪物1"], ["hp", 90], ["atk", 10]]],
		[personService.query(mobs[1]), [["username", "普通怪物1"], ["hp", 40], ["atk", 10]]],
	]
	for v in arr:
		for sv in v[1]:
			assert(v[0].get(sv[0]) == sv[1])
			
	# 玩家攻击所有怪物, 直到怪物被消灭
	while true:
		var is_all_over = false
		for mob in mobs:
			actionService.attack(player[0], mob)
		if personService.query(mobs[0]).hp <= 0 and personService.query(mobs[1]).hp <= 0:
			break
		if is_all_over:
			break
			
	arr = [
		[personService.query(player[0]), [["username", "玩家1"], ["hp", 180], ["atk", 10]]],
		[personService.query(mobs[0]), [["username", "BOSS怪物1"], ["hp", 0], ["atk", 10]]],
		[personService.query(mobs[1]), [["username", "普通怪物1"], ["hp", -50], ["atk", 10]]],
	]
	for v in arr:
		for sv in v[1]:
			assert(v[0].get(sv[0]) == sv[1], "%s == %s" % [v[0].get(sv[0]), sv[1]])
	
	print("测试数据结束")

func test_view():
	print("测试视图开始")
	visible = true
	
	
	print("测试视图结束")
	
func _ready() -> void:
	#Framework.is_debug = false
	test_data()
	#test_view()
