tool
extends MarginContainer

onready var data                  = $Data
onready var spritesheet_generator = $SpriteSheetGenerator
onready var options               = $VBoxContainer/Mid/Options
onready var actions               = $VBoxContainer/Actions
onready var file_list             = $VBoxContainer/Mid/FileList

func _on_files_selected(files : Array):
	options.enabled = files.size() > 0
	actions.enabled = options.enabled

func _on_process_started(output_file : String):
	data.output_file = output_file
	spritesheet_generator.process(data)

func _ready():
	options.connect("changed", data, "_on_options_changed")
	options.connect("changed", file_list, "_on_options_changed")
	actions.connect("files_selected", self, "_on_files_selected")
	actions.connect("files_selected", data, "_on_files_selected")
	actions.connect("files_selected", options, "_on_files_selected")
	actions.connect("files_selected", file_list, "_on_files_selected")
	actions.connect("process_started", self, "_on_process_started")
