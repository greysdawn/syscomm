local NP={}

function NP:enter()
  posx,posy=love.mouse.getPosition()
  Display.clear()
end

function NP:update()
  posx,posy=love.mouse.getPosition()
end

function NP:keypressed(k)
  if k=="escape" then
    Gamestate.switch(testroom)
  end
end

function NP:draw()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end

return NP
