--what the login page will look like/where all code works for the login page's structure

local LP={}
logtab={}

function LP:enter()
  Display.clear()
  love.graphics.setBackgroundColor(150,150,150,255)
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  posx,posy=love.mouse.getPosition()
  usn=IBox:new{chars={},c={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=ww/2-100,y=200,w=200,h=20,ts=18,text="user",fetchcode="usn"}
  pas=IBox:new{chars={},c={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=ww/2-100,y=240,w=200,h=20,ts=18,text="pass",fetchcode="pas"}
  log=Button:new{c1={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=ww/2-120,y=280,w=100,h=20,ts=18,text="  LOG IN",onclick=function()
    er1:hide()
    er2:hide()
    er3:hide()
    Login.login(usn.text,pas.text)
  end,fetchcode="log"}
  reg=Button:new{c1={255,255,255,255},c2={255,200,200,255},tc={0,0,0,255},x=ww/2+20,y=280,w=100,h=20,ts=18,text="REGISTER",onclick=function()
    er1:hide()
    er2:hide()
    er3:hide()
    Login.register(usn.text,pas.text)
  end,fetchcode="reg"}
  er1=SBox:new{c={0,0,0,0},tc={255,0,0,255},x=ww/2-135,y=150,w=270,h=30,ts=18,text="Login failed; not registered",hidden=true,fetchcode="er1"}
  er2=SBox:new{c={0,0,0,0},tc={255,0,0,255},x=ww/2-135,y=150,w=270,h=30,ts=18,text="Login failed; wrong password",hidden=true,fetchcode="er2"}
  er3=SBox:new{c={0,0,0,0},tc={255,0,0,255},x=ww/2-135,y=150,w=270,h=30,ts=18,text="Register failed; already registered",hidden=true,fetchcode="er3"}
end

function LP:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
end

function LP:textinput(t)
    Display.text(t)
end

function LP:keypressed(key)
  if key=="escape" then
    love.event.quit()
  end
  if key=="tab" then
    if usn.active then
      usn.active=false
      pas.active=true
    elseif pas.active then
      pas.active=false
      usn.active=true
    else
      usn.active=true
    end
  end
  if key=="return" and string.len(usn.text)>0 and string.len(pas.text)>0 then
    er1:hide()
    er2:hide()
    er3:hide()
    Login.login(usn.text,pas.text)
  end
end

function LP:draw()
  Display.all()
  love.graphics.setNewFont(24)
  love.graphics.setColor({255,255,255,255})
  love.graphics.print("Please log in or register.",ww/2-135,100) --notes[1].title.."   "..notes[1].text.."   "..
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end

function love.mousereleased(x,y,btn)
  if btn==1 then
    Display.clicks(x,y)
  end
end

return LP
