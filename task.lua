local tArgs = { ... }
if #tArgs < 1 then
	h = fs.open("task", "r")
	print(h.readLine())
	h.close()
	return
end

h = fs.open("task", "w")
h.writeLine(table.concat(tArgs," "));
h.close()