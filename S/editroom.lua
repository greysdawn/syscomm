local editroom={}

function editroom:enter()
  Display.clear()
  posx,posy=love.mouse.getPosition()
  testbox=SBox:new{x=100,y=100,w=400,h=100,ts=100,fetchcode="tbox"}
  testbutton=Button:new{x=100,y=200,w=200,h=100,ts=50,c2={200,100,100,255},fetchcode="tbut"}
  testmenu=Menu:new({btns={},x=0,y=0,w=100,h=30,bth=20,text="Menu Test",fetchcode="menu1"},{{"b1","Slide Right",function()
    testmenu:xslide(love.graphics.getWidth()-testmenu.w,20)
  end},{"b2","Slide Left",function()
    testmenu:xslide(0,10)
  end}})
  testmenu2=Menu:new({btns={},x=110,y=0,w=100,h=30,bth=20,text="Menu test2",fetchcode="menu2"},{{"mb1","test",function()
    testmenu2:yslide(100,10)
  end},{"mb2","test2",function()
    testmenu2:yslide(0,10)
  end}})
  testibox=IBox:new{x=0,y=400,w=200,h=20,chars={},fetchcode="ibox1"}
  testibox2=IBox:new{x=0,y=440,w=200,h=20,chars={},fetchcode="ibox2"}
end

function editroom:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
end

function editroom:textinput(t)
  testibox:updtext(t)
  testibox2:updtext(t)
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
  love.graphics.print(testibox.text,0,500)
end

return editroom
