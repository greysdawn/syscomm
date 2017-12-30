-- Scripts --
Data=require("C.data")
Display=require("C.display")
Gamestate=require("C.gamestate")
Login=require("C.login")
-- End Scripts --

-- States --
--LP=require("S.loginpage")
--notesroom=require("S.notesroom")
editroom=require("S.editroom")
--deleteroom=require("S.deleteroom")
-- End States --

function love.load()
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()

  Gamestate.registerEvents()
  Gamestate.switch(editroom)
end
