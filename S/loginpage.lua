--what the login page will look like/where all code works for the login page's structure

local LP={}
logtab={}

function LP:enter()
  Display.clear()
  love.graphics.setBackgroundColor(150,150,150,255)
  posx,posy=love.mouse.getPosition()
  Display.create("ibox","usn",{255,255,255,255},{255,200,200,255},{0,0,0,255},ww/2-100,200,200,20,16)
  Display.create("ibox","pas",{255,255,255,255},{255,200,200,255},{0,0,0,255},ww/2-100,240,200,20,16)
  Display.create("button","log",{255,255,255,255},{255,200,200,255},{0,0,0,255},ww/2-100,280,80,20,16,"fill","  LOG IN")
  Display.create("button","reg",{255,255,255,255},{255,200,200,255},{0,0,0,255},ww/2+20,280,80,20,16,"fill","REGISTER")
  Display.create("simpbox","er1",{0,0,0,0},{0,0,0,0},{255,0,0,255},ww/2-135,150,270,30,16,"fill","Login failed; not registered",true)
  Display.create("simpbox","er2",{0,0,0,0},{0,0,0,0},{255,0,0,255},ww/2-135,150,270,30,16,"fill","Login failed; incorrect password",true)
  Display.create("simpbox","er3",{0,0,0,0},{0,0,0,0},{255,0,0,255},ww/2-135,150,270,30,16,"fill","Register failed; already registered",true)
  ert=""
end

function LP:update(dt)
  ab=Display.getActiveButton()
  posx,posy=love.mouse.getPosition()
  --Display.ibox_upd(dt,"usn")
  --Display.ibox_upd(dt,"pas")
  --Display.button_upd("log")
  --Display.button_upd("reg")
  Display.update(dt)

  if ab=="log" then
    Display.setActiveButton("none")
    Display.hidebox("er1")
    Display.hidebox("er2")
    Display.hidebox("er3")
    Login.login(boxes["usn"].text,boxes["pas"].text)

  elseif ab=="reg" then
    Display.setActiveButton("none")
    Display.hidebox("er1")
    Display.hidebox("er2")
    Display.hidebox("er3")
    Login.register(boxes["usn"].text,boxes["pas"].text)

  end
end

function LP:textinput(t)
    Display.text(t)
end

function LP:keypressed(key)
  if key=="escape" then
    love.event.quit()
  end

  Login.lkeys(key)

end

function LP:draw()
  Display.all()
  love.graphics.setNewFont(24)
  love.graphics.setColor({255,255,255,255})
  love.graphics.print("Please log in or register.",ww/2-135,100) --notes[1].title.."   "..notes[1].text.."   "..
  love.graphics.setColor({255,0,0,255})
  love.graphics.setNewFont(16)
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end

return LP
