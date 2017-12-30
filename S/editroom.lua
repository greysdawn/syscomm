local editroom={}

function editroom:enter()
  posx,posy=love.mouse.getPosition()
  testbox=Box:new{x=100,y=100,w=400,h=100,ts=100}
  testbutton=Button:new{x=100,y=200,w=200,h=100,ts=50,c2={200,100,100,255}}
end

function editroom:update(dt)

  posx,posy=love.mouse.getPosition()
  if posx>=testbutton.x and posx<=testbutton.x+testbutton.w and posy>=testbutton.y and posy<=testbutton.y+testbutton.h then
    testbutton:setActive(true)
  else
    testbutton:setActive(false)
  end

end

function editroom:keypressed(k)
  if k=="escape" then
    love.event.quit()
  end
end

function editroom:draw()
  testbox:draw()
  testbutton:draw()
end

return editroom
