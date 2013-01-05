shell.setDir("/git")
os.loadApi("tl");

-- drop to next level
shell.run("q-deploy.lua")

shell.run("quarry.lua")
x,y = term.getCursorPos()
term.setCursorPos(1,y+5);

shell.run("q-light-home.lua")