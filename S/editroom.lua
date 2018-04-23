local editroom={}

function editroom:enter()
  Display.clear()
  posx,posy=love.mouse.getPosition()
  nbgr,nbgg,nbgb,nbga=string.match(confs[cLog.user].nc,"(%d+),(%d+),(%d+),(%d+)")
  ntcr,ntcg,ntcb,ntca=string.match(confs[cLog.user].tc,"(%d+),(%d+),(%d+),(%d+)")
  note_title=IBox:new{c={nbgr/255,nbgg/255,nbgb/255,100/255},c2={nbgr/255,nbgg/255,nbgb/255,1},tc={ntcr,ntcg,ntcb,ntca},x=0,y=30,w=love.graphics.getWidth(),h=50,ts=18,text=cNote.title,max=100,fetchcode="entitle"}
  note_text=IBox:new{c={nbgr/255,nbgg/255,nbgb/255,100/255},c2={nbgr/255,nbgg/255,nbgb/255,1},tc={ntcr,ntcg,ntcb,ntca},x=0,y=80,w=love.graphics.getWidth(),h=love.graphics.getWidth()/2,text=cNote.text,max=2048,fetchcode="entext"}
  s_n=Button:new{c={1,100/255,100/255,1},c2={1,1,1,1},tc={0,0,0,1},x=love.graphics.getWidth()/2-200,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=18,text="Save",fetchcode="ens_n",onclick=function()
    Data.deleteN(cNote.title)
    Data.addN(note_title.text,note_text.text,cNote.auth,cLog.user)
    Gamestate.switch(notesroom)
  end}
  can=Button:new{c={1,100/255,100/255,1},c2={1,1,1,1},tc={0,0,0,1},x=love.graphics.getWidth()/2+100,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=18,text="Cancel",fetchcode="encan",onclick=function()
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
  love.graphics.setColor({1,1,1,1})
  love.graphics.draw(cursor,posx,posy)
end

return editroom
