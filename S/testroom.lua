local troom={}

function troom:enter()
  Display.clear()
  tmen=Menu:new({c={255,100,100,255},c2={255,200,200,255},tc={0,0,0,255},x=0,y=62,w=100,h=20,bth=20,ts=18,mode="fill",text="Menu",fetchcode="1menu"},{{"lo","Log out",function()
    Gamestate.switch(LP)
  end}})
  tmen2=Menu:new({c={255,100,100,255},c2={255,200,200,255},tc={0,0,0,255},x=200,y=62,w=100,h=20,bth=20,ts=18,mode="fill",text="Menu",fetchcode="0menu"},{{"ex","Exit",function()
    love.event.quit()
  end}})
end

function troom:update(dt)
  Display.update(dt)
  posx,posy=love.mouse.getPosition()
end

function troom:draw()
  Display.all()
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(cursor,posx,posy)
end

return troom
