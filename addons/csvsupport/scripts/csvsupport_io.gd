##############################
# csv preview io manager
# 2023/10/24 09:44
# HongSong
##############################
@tool
extends Control

var path = "res://others/csv/newcsv.csv"

#save a new csv
func save_new_csv():
	var content = csvsupport_csvdata.new().to_str()
	write(path,content)

#read as csv file
func read_as_csv()->csvsupport_csvdata:
	var csv_data = csvsupport_csvdata.new()
	return csv_data

#save as csv 
func save_as_csv(csv_data:csvsupport_csvdata):
	write(path,csv_data.to_str())

#read file 
func read(path)->String:
	var io = FileAccess.open(path,FileAccess.READ)
	return io.get_as_text()
	io.flush()
	io.close()

#save file
func write(path,content):
	var io = FileAccess.open(path,FileAccess.WRITE)
	io.store_string(content)
	io.flush()
	io.close()
	



