extends Node

@onready var joysticks: CanvasLayer = $/root/Main/HUD/InGameHUD/Joysticks;
@onready var player_health_bar: HealthBar = $/root/Main/HUD/InGameHUD/PlayerHealthBar;
@onready var levelup_hud: CanvasLayer = $/root/Main/HUD/LevelupHUD;

func hide_joysticks() -> void:
	for joystick: VirtualJoystick in joysticks.find_children("*Joystick", "VirtualJoystick", false):
		joystick._reset();
		joystick.hide();
	joysticks.process_mode = PROCESS_MODE_DISABLED;

func show_joysticks() -> void:
	joysticks.process_mode = PROCESS_MODE_INHERIT;

func show_levelup_hud():
	levelup_hud.show();
	hide_joysticks();

func hide_levelup_hud():
	levelup_hud.hide();
	show_joysticks();