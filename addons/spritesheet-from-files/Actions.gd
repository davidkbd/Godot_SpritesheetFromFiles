tool
extends HBoxContainer

signal files_selected(files)
signal process_started(output_file)

export(bool) var enabled : bool = false setget set_enabled, is_enabled

onready var select_files_button : Button = $SelectFilesButton
onready var process_button      : Button = $ProcessButton

func set_enabled(new_enabled : bool):
	enabled = new_enabled
	if $ProcessButton:
		$ProcessButton.disabled = !enabled

func is_enabled() -> bool: return enabled

func _on_files_selected(files : PoolStringArray):
	var file_list : Array = []
	for file in files: file_list.append(file)
	file_list.sort()
	emit_signal("files_selected", file_list)

func _on_select_files():
	var dialog = FileDialog.new()
	dialog.mode = FileDialog.MODE_OPEN_FILES
	dialog.filters = [ "*.png" ]
	dialog.window_title = "Select PNGs to convert"
	dialog.dialog_text = "You can select one or more PNG files to create a spritesheet"
	dialog.connect('modal_closed', dialog, 'queue_free')
	dialog.connect("files_selected", self, "_on_files_selected")
	add_child(dialog)
	dialog.popup_centered_ratio()

func _on_output_file_selected(path : String):
	emit_signal("process_started", path)

func _on_process():
	var dialog = FileDialog.new()
	dialog.mode = FileDialog.MODE_SAVE_FILE
	dialog.filters = [ "*.png" ]
	dialog.window_title = "Save your spritesheet"
	dialog.dialog_text = "Select a directory and save your spritesheet"
	dialog.connect('modal_closed', dialog, 'queue_free')
	dialog.connect("file_selected", self, "_on_output_file_selected")
	add_child(dialog)
	dialog.popup_centered_ratio()

func _ready():
	select_files_button.connect("pressed", self, "_on_select_files")
	process_button.connect("pressed", self, "_on_process")
	select_files_button.disabled = false
	process_button.disabled = true
