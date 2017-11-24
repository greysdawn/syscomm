local testroom={}

function testroom:enter()
  love.graphics.setBackgroundColor({0,0,0,255})
  Display.setActiveButton("none")
  Display.create("menu","Logout",{255,255,255,255},{255,200,200,255},{255,0,0,255},0,30,100,20,14,"line",{lo="LOG OUT",ex="EXIT"},true)
  Display.create("button","testwin",{255,255,255,255},{255,0,0,255},{0,0,0,255},100,0,100,20,15,"fill","Test Window",false)
  Display.create_window("test",{225,200,200,255},{255,255,255,255},{0,0,0,255},0,0,100,100,true)
  Display.add("button","test",{t={{255,0,0,255},{0,0,0,255},{255,255,255,255},0,10,10,10,2,"fill","test",false},c={{255,0,0,255},{0,0,0,255},{255,255,255,255},0,20,10,10,2,"fill","test2",false}})
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
  if Display.getActiveButton()=="testwin" then
    windows["test"].hidden=false
  end
  Display.window_upd("test")
  Display.button_upd("testwin")
end

function testroom:draw()
  Display.menu("Logout")
  Display.button("testwin")
  Display.window("test")
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
