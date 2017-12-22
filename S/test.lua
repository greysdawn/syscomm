local testroom={}

function testroom:enter()
  Display.clear()
  Save.readNotes()
  love.graphics.setBackgroundColor({252, 250, 204,255})
  Display.setActiveButton("none")
  Display.create("menu","Logout",{100,0,0,255},{255,200,200,255},{255,0,0,255},ww,30,100,20,14,"fill",{lo="LOG OUT",ex="EXIT"})
  Display.create("simpbox","tbar",{255,150,150,255},{255,150,150,255},{255,255,255,255},0,0,love.graphics.getWidth(),30,20,"fill","NOTES")
  Display.create("simpbox","n_p",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,30,love.graphics.getWidth()/2,love.graphics.getHeight()-30,16,"fill","Note preview")
  Display.create("button","tm",{255,100,100,255},{255,255,255,255},{255,255,255,255},love.graphics.getWidth()-30,0,30,30,30,"fill","---")
  local ac="none"
  local acb="none"
end

function testroom:update(dt)
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
  ac=Display.getActiveOption("Logout")
  acb=Display.getActiveButton()

  if acb=="tm" or ac=="ex" or ac=="lo" then
    Display.tofront("Logout")
      Display.slide("Logout",ww-100,2)
  else
    Display.slide("Logout",ww,2)
  end
  if ac=="ex" then
    love.event.quit()
  end
  if ac == "lo" then
    Display.setActiveButton("none")
    ac=nil
    Gamestate.switch(LP)
  end

  if acb~="none" then
    if buttons[acb].type=="note" then
      cNote.title=acb
      cNote.text=notes[acb]
      Display.setActiveButton("none")
      Gamestate.switch(NP)
    end
  end

end

function testroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end


return testroom
