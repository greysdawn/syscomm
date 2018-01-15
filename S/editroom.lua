local editroom={}

function editroom:enter()
  Display.clear()
  posx,posy=love.mouse.getPosition()
  note_title=IBox:new{chars={},c={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=0,y=30,w=love.graphics.getWidth(),h=50,ts=18,text=cNote.title,max=100,fetchcode="entitle"}
  note_text=IBox:new{chars={},c={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=0,y=80,w=love.graphics.getWidth(),h=love.graphics.getWidth()/2,text=cNote.text,max=2048,fetchcode="entext"}
  s_n=Button:new{c={255,100,100,255},c2={255,255,255,255},tc={0,0,0,255},x=love.graphics.getWidth()/2-200,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=18,text="Save",fetchcode="ens_n",onclick=function()
    Data.deleteN(cNote.title)
    Data.addN(note_title.text,note_text.text,cNote.auth,cLog.user)
    Gamestate.switch(notesroom)
  end}
  can=Button:new{c={255,100,100,255},c2={255,255,255,255},tc={0,0,0,255},x=love.graphics.getWidth()/2+100,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=18,text="Cancel",fetchcode="encan",onclick=function()
    Gamestate.switch(notesroom)
  end}
end

function editroom:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
end

function editroom:textinput(t)
  Display.text(t)
end

function editroom:keypressed(k)
  if k=="escape" then
    love.event.quit()
  end
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
