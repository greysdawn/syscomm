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




  first_note_title="My first note!"
  first_note_text="Hey there! Thank you for using Syscomm. Here is your first note :D"
  second_note_title="To-Do"
  second_note_text="Be safe, be happy, be cool B)"
  third_note_title="Meow"
  third_note_text="I'm a cat!"

  ts={}
  ts[1]=first_note_title.."|"..first_note_text
  ts[2]=second_note_title.."|"..second_note_text
  ts[3]=third_note_title.."|"..third_note_text

  if not love.filesystem.exists("data.data") then
    love.filesystem.write("data.data","")
    Save.prepNotes(ts)
    Save.saveN()
  end

  Gamestate.registerEvents()
  Gamestate.switch(LP)
end
