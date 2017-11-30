local testroom={}

function testroom:enter()
  Display.clear()
  love.graphics.setBackgroundColor({0,0,0,255})
  Display.setActiveButton("none")
  Display.create("menu","Logout",{0,0,0,255},{255,200,200,255},{255,0,0,255},0,30,100,20,14,"fill",{lo="LOG OUT",ex="EXIT"},true)
  Display.create("button","testwin",{255,255,255,255},{255,0,0,255},{0,0,0,255},100,0,100,20,15,"fill","Test Window",false)
  Display.create_window("test",{225,200,200,255},{255,255,255,255},{0,0,0,255},0,0,100,100,true)
  Display.add("button","test",{t={{255,0,0,255},{0,0,0,255},{255,255,255,255},0,10,10,10,2,"fill","test"},c={{255,0,0,255},{0,0,0,255},{255,255,255,255},0,20,10,10,2,"fill","test2"}})
end

function testroom:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
  local ac=Display.getActiveOption("Logout")
  local acb=Display.getActiveButton()

  if ac=="ex" then
    love.event.quit()
  end
  if acb=="testwin" then
    windows["test"].hidden=false
  end
  if ac == "lo" then
    Display.setActiveButton("none")
    ac=nil
    Gamestate.switch(LP)
  end

end

function testroom:draw()
  --Display.menu("Logout")
  --Display.window("test")
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.setNewFont(16)
  love.graphics.print("Success!",ww/2-30,wh/2)
  love.graphics.draw(cursor,posx,posy)
  love.graphics.print(table.concat(z," "),0,.9*wh)
end

function testroom:keypressed(k)
  if k=="escape" then
    if menus["Logout"].hidden then
      Display.tofront("Logout")
      Display.showmenu("Logout")
    else
      Display.hidemenu("Logout")
    end
  end
end

return testroom
