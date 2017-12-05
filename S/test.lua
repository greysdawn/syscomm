local testroom={}

function testroom:enter()
  Display.clear()
  Save.readNotes()
  love.graphics.setBackgroundColor({252, 250, 204,255})
  Display.setActiveButton("none")
  Display.create("menu","Logout",{100,0,0,255},{255,200,200,255},{255,0,0,255},love.graphics.getWidth(),30,100,20,14,"fill",{lo="LOG OUT",ex="EXIT"})
  Display.create("menu","droptest",{100,0,0,255},{255,200,200,255},{255,0,0,255},0,-100,100,20,14,"fill",{db="BUTTON",xp="ABUTT"})
  Display.create("simpbox","tbar",{255,150,150,255},{255,150,150,255},{255,255,255,255},0,0,love.graphics.getWidth(),30,20,"fill","NOTES")
  Display.create("button","tm",{255,100,100,255},{255,255,255,255},{255,255,255,255},love.graphics.getWidth()-30,0,30,30,14,"fill","---\n---\n---")
  local mt=0
  local mm=false
end

function testroom:update(dt)
  if love.mouse.isDown(1) then
    mm=true
  else
    mm=false
  end
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
  local ac=Display.getActiveOption("Logout")
  local acb=Display.getActiveButton()

  if acb=="tm" or ac=="ex" or ac=="lo" then
      Display.slide("Logout",ww-100,2)
      Display.drop("droptest",30,2)
  else
    Display.slide("Logout",ww,2)
    Display.drop("droptest",-100,2)
  end
  if ac=="ex" then
    love.event.quit()
  end
  if ac == "lo" then
    Display.setActiveButton("none")
    ac=nil
    Gamestate.switch(LP)
  end


end

function testroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.setNewFont(16)
  love.graphics.print("Success!",ww/2-30,wh/2)
  love.graphics.draw(cursor,posx,posy)
  love.graphics.print(table.concat(z," "),0,.9*wh)
end


return testroom
