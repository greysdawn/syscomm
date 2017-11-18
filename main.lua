-- Scripts --
Save=require("C.save")
Display=require("C.display")
Gamestate=require("C.gamestate")
Login=require("C.login")
-- End Scripts --

-- States --
LP=require("S.loginpage")
testroom=require("S.test")
-- End States --

function love.load()
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  logbox=0
  love.mouse.setVisible(false)
  cursor = love.graphics.newImage("Media/cursor.png")

  if not love.filesystem.exists("logs.data") then
    love.filesystem.write("logs.data","")
  end

  if not love.filesystem.exists("data.data") then
    love.filesystem.write("data.data","")
  end


  first_note_title="Test"
  first_note_text="This is a simple test."
  second_note_title="Test2"
  second_note_text="This is a second test."

  ts={}
  ts[first_note_title]=first_note_text
  ts[second_note_title]=second_note_text

  Save.prepNotes(ts)
  Save.saveN()
  Save.readNotes()

  Gamestate.registerEvents()
  Gamestate.switch(LP)
end
