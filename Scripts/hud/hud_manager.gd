extends Node

@onready var joysticks: CanvasLayer = $/root/Main/HUD/InGameHUD/Joysticks;
@onready var player_health_bar: HealthBar = $/root/Main/HUD/InGameHUD/PlayerHealthBar;
@onready var xp_bar: XpBar = $/root/Main/HUD/InGameHUD/XpBar;
@onready var levelup_hud: CanvasLayer = $/root/Main/HUD/LevelupHUD;
@onready var start_button: Button = $/root/Main/HUD/StartButton;

func _ready() -> void:
	start_button.pressed.connect(func(): restart_game());

func hide_joysticks() -> void:
	for joystick: VirtualJoystick in joysticks.find_children("*Joystick", "VirtualJoystick", false):
		joystick._reset();
		joystick.hide();
	joysticks.process_mode = PROCESS_MODE_DISABLED;

func show_joysticks() -> void:
	joysticks.process_mode = PROCESS_MODE_INHERIT;

func show_levelup_hud() -> void:
	levelup_hud.show();
	hide_joysticks();

func hide_levelup_hud() -> void:
	levelup_hud.hide();
	show_joysticks();

func restart_game() -> void:
	LevelData.reset();
	LevelManager.reload_level();
	start_button.hide();
	xp_bar.reset();
	show_joysticks();
