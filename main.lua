-- Scripts --
Data=require("C.data")
Display=require("C.display")
Gamestate=require("C.gamestate")
Login=require("C.login")
-- End Scripts --

-- States --
LP=require("S.loginpage")
notesroom=require("S.notesroom")
editroom=require("S.editroom")
--deleteroom=require("S.deleteroom")
-- End States --

function love.load()
  cursor=love.graphics.newImage("M/cursor.png")
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  love.mouse.setVisible(false)
  Gamestate.registerEvents()
  Gamestate.switch(LP)
end
