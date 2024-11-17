extends Node

func pause_game():
	_pause_game.call_deferred(true);

func unpause_game():
	_pause_game.call_deferred(false);

func _pause_game(pause: bool):
	self.process_mode = PROCESS_MODE_DISABLED if pause else PROCESS_MODE_INHERIT;