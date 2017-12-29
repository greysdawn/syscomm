local deleteroom={}

function deleteroom:enter()
  Display.clear()
  posx,posy=love.mouse.getPosition()
  Display.create("button","y",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2-200,love.graphics.getHeight()/2+100,100,30,16,"fill","Yes")
  Display.create("button","n",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2+100,love.graphics.getHeight()/2+100,100,30,16,"fill","No")
  Display.create("simpbox","curnote",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2-100,love.graphics.getHeight()/2-100,200,20,16,"fill",cNote.title)
  Display.create("simpbox","ays",{0,0,0,0},{0,0,0,0},{255,0,0,255},love.graphics.getWidth()/2-160,love.graphics.getHeight()/2-200,400,100,16,"fill","Are you sure you want to delete this?")
end

function deleteroom:update()
  posx,posy=love.mouse.getPosition()
  Display.update()

  if Display.getActiveButton()=="y" then
    Data.deleteN(cNote.title)
    Gamestate.switch(notesroom)
  elseif Display.getActiveButton()=="n" then
    Gamestate.switch(notesroom)
  end
end

function love.mousereleased(x,y,btn)
    if btn==1 then
      Display.clicks(x,y)
    end
end

function deleteroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end

return deleteroom
