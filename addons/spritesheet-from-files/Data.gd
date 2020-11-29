tool
extends Node

var frame_width      : int
var frame_height     : int
var items_per_row    : int
var files            : Array
var output_file      : String

func _on_files_selected(new_files : Array):
	files = new_files

func _on_options_changed(new_width : int, new_height : int, new_items_per_row : int):
	frame_width = new_width
	frame_height = new_height
	items_per_row = new_items_per_row
