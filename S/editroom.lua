local editroom={}

function editroom:enter()
  posx,posy=love.mouse.getPosition()
  Display.clear()
  Display.create("ibox","note_title",{255,255,255,255},{255,200,200,255},{0,0,0,255},0,30,love.graphics.getWidth(),50,16,"fill",cNote.title,false,100)
  Display.create("ibox","note_text",{255,255,255,255},{255,200,200,255},{0,0,0,255},0,80,love.graphics.getWidth(),love.graphics.getHeight()/2,16,"fill",cNote.text,false,2048)
  Display.create("button","s_n",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2-200,love.graphics.getHeight()/2+100,100,30,16,"fill","Save")
  Display.create("button","can",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2+100,love.graphics.getHeight()/2+100,100,30,16,"fill","cancel")
end

function editroom:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)

  if Display.getActiveButton()=="can" then
    Gamestate.switch(notesroom)
  end

  if Display.getActiveButton()=="s_n" then
    Data.deleteN(cNote.title)
    Data.addN(Display.getVal("note_title"),Display.getVal("note_text"),cNote.auth,cLog.user)
    Gamestate.switch(notesroom)
  end
end

function editroom:keypressed(k)
  if k=="escape" then
    Gamestate.switch(notesroom)
  end
end

function editroom:textinput(t)
    Display.text(t)
end

function love.mousereleased(x,y,btn)
  if btn==1 then
    Display.clicks(x,y)
  end
end

function editroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end

return editroom
