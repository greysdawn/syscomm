local testroom={}

function testroom:enter()
  love.graphics.setBackgroundColor({0,0,0,255})
  Display.setActiveButton("none")
  Display.create_menu("Logout",{lo="LOG OUT",ex="EXIT"},{255,255,255,255},{255,200,200,255},{255,0,0,255},0,30,100,20,14,"line",true)
end

function testroom:update()
  posx,posy=love.mouse.getPosition()
  Display.menu_upd("Logout")

  if Display.getActiveOption("Logout") == "lo" then
    Display.setActiveButton("none")
    Gamestate.switch(LP)
  end
  if Display.getActiveOption("Logout")=="ex" then
    love.event.quit()
  end
end

function testroom:draw()
  Display.menu("Logout")
  love.graphics.setColor({255,255,255,255})
  love.graphics.setNewFont(16)
  love.graphics.print("Success!",ww/2-30,wh/2)
  love.graphics.draw(cursor,posx,posy)

end

function testroom:keypressed(k)
  if k=="escape" then
    if menus["Logout"].hidden then
      Display.showmenu("Logout")
    else
      Display.hidemenu("Logout")
    end
  end
end

return testroom
