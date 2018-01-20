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
deleteroom=require("S.deleteroom")
sroom=require("S.setroom")
testroom=require("S.testroom")
-- End States --

function love.load()
  cursor=love.graphics.newImage("M/cursor.png")
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  love.mouse.setVisible(false)
  Gamestate.registerEvents()
  Gamestate.switch(LP)

  if not love.filesystem.exists("logs.data") then
    love.filesystem.write("logs.data","")
  end


  if not love.filesystem.exists("data.data") then
    love.filesystem.write("data.data",Data.encrypt("First note").."|"..Data.encrypt("Thank you for using Syscomm! So far, this is mostly just a prototype. Please be patient and careful with it, and if anything breaks, don't be afraid to let us know!").."|"..Data.encrypt("The Grey Skies").."|"..Data.encrypt("Above this is the original note author, right here is where you'll find the last editor~").."\n")
  end

end
