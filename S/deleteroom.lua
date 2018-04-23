local deleteroom={}

function deleteroom:enter()
  Display.clear()
  posx,posy=love.mouse.getPosition()
  dry=Button:new{c={1,100/255,100/255,1},c2={1,1,1,1},tc={0,0,0,1},x=love.graphics.getWidth()/2-200,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=16,text="Yes",fetchcode="dry",onclick=function()
    Data.deleteN(cNote.title)
    Gamestate.switch(notesroom)
  end}
  drn=Button:new{c={1,100,100,1},c2={1,1,1,1},tc={0,0,0,1},x=love.graphics.getWidth()/2+100,y=love.graphics.getHeight()/2+100,w=100,h=30,ts=16,text="No",fetchcode="drn",onclick=function()
    Gamestate.switch(notesroom)
  end}
  curnote=SBox:new{c={1,1,1,1},tc={0,0,0,1},x=love.graphics.getWidth()/2-100,y=love.graphics.getHeight()/2-100,w=200,h=20,ts=16,text=cNote.title,fetchcode="curnote"}
  ays=SBox:new{c={0,0,0,0},tc={1,0,0,1},x=love.graphics.getWidth()/2-160,y=love.graphics.getHeight()/2-200,w=400,h=100,ts=16,text="Are you sure you want to delete this?",fetchcode="ays"}
end

function deleteroom:update()
  posx,posy=love.mouse.getPosition()
  Display.update()
end

function love.mousereleased(x,y,btn)
    if btn==1 then
      Display.clicks(x,y)
    end
end

function deleteroom:draw()
  Display.all()
  love.graphics.setColor({1,1,1,1})
  love.graphics.draw(cursor,posx,posy)
end

return deleteroom
