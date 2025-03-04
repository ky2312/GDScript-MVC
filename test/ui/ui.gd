extends Node2D

func _ready() -> void:
	var framework = Framework.new()
	var repository = FrameworkRepository.MemoryFrameworkRepository.new()
	var personService = PersonService.new(repository)
	var actionService = ActionService.new(repository)
	
	var step = [0]
	var player = []
	var mobs: Array[int] = []
	
	var tt = Timer.new()
	add_child(tt)
	tt.connect("timeout", func():
		step[0] += 1
		var console = func():
			var _p = personService.query(player[0])
			var _mob1 = personService.query(mobs[0])
			var _mob2 = personService.query(mobs[1])
			print("%ss 创建: player(hp:%s atk:%s), mobs(hp:%s atk:%s, hp:%s atk:%s)" % [step[0], _p.hp, _p.atk, _mob1.hp, _mob1.atk, _mob2.hp, _mob2.atk])

		match step[0]:
			# 创建玩家和怪物
			1:
				player.append(personService.add_player("玩家1", 100, 10).id)
				mobs.append(personService.add_mob("BOSS怪物1", 100, 10).id)
				mobs.append(personService.add_mob("普通怪物1", 50, 10).id)
				console.call()
			# 玩家攻击所有怪物
			2:
				for mob in mobs:
					actionService.attack(player[0], mob)
				console.call()
			# 所有怪物攻击玩家
			3:
				for mob in mobs:
					actionService.attack(mob, player[0])
				console.call()
			# 玩家被治疗
			4:
				actionService.cure(player[0], 100)
				console.call()
			# 玩家攻击所有怪物, 直到怪物被消灭
			5:
				while true:
					var is_all_over = false
					for mob in mobs:
						actionService.attack(player[0], mob)
					if personService.query(mobs[0]).hp <= 0 and personService.query(mobs[1]).hp <= 0:
						break
					console.call()
					if is_all_over:
						break
			_:
				console.call()
				print("结束")
				tt.stop()
	)
	tt.start()
