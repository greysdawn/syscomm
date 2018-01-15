local notesroom={}
local ac="none"
local acb="none"

function notesroom:enter()
  Display.clear()
  Data.readNotes()
  love.graphics.setBackgroundColor({252, 250, 204,255})
  cNote.title="No note chosen."
  cNote.text=""
  cNote.auth=""
  cNote.le=""
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  n_menu=Menu:new({btns={},c={255,100,100,255},c2={255,200,200,255},tc={0,0,0,255},x=ww,y=30,w=100,h=20,bth=20,ts=18,mode="fill",text="Menu",fetchcode="nmenu"},{{"lo","Log out",function()
    Gamestate.switch(LP)
  end},{"ex","Exit",function()
    love.event.quit()
  end}})
  tbar=SBox:new{c={255,150,150,255},c2={255,150,150,255},tc={255,255,255,255},x=0,y=0,w=ww,h=30,ts=28,text="NOTES",fetchcode="tbar"}
  n_p=SBox:new{c={255,255,255,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=30,w=ww/2,h=wh-30,ts=18,text="",fetchcode="nprev"}
  n_ti=SBox:new{c={255,255,255,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=30,w=ww/2,h=50,ts=18,text=cNote.title,fetchcode="nti"}
  n_te=SBox:new{c={255,255,255,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=80,w=ww/2,h=wh/2,ts=18,text=cNote.text,fetchcode="nte"}
  n_auth=SBox:new{c={255,255,255,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=wh/2+50,w=ww/2,h=50,ts=18,text=cNote.auth,fetchcode="nauth"}
  n_le=SBox:new{c={255,255,255,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=wh/2+100,w=ww/2,h=50,ts=18,text=cNote.le,fetchcode="nle"}
  tm=Button:new{c={255,100,100,255},c2={255,0,0,255},hc={100,100,100,255},tc={255,255,255,255},x=ww-30,y=0,w=30,h=30,ts=30,text="X",fetchcode="mbut"}
  e_n=Button:new{c={255,100,100,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2,y=wh/2+150,w=100,h=30,ts=20,text="Edit",fetchcode="en",onclick=function()
    if cNote.title~="No note chosen." then
      Gamestate.switch(editroom)
    end
  end}
  d_n=Button:new{c={255,100,100,255},c2={255,255,255,255},tc={0,0,0,255},x=ww/2+110,y=wh/2+150,w=100,h=30,ts=20,text="Delete",fetchcode="dn",onclick=function()
    if cNote.title~="No note chosen." then
      Gamestate.switch(deleteroom)
    end
  end}
end

function notesroom:update(dt)
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
  if tm.active then
    n_menu:tofront()
    n_menu:xslide(ww-100,5)
  else
    n_menu:xslide(ww,5)
  end
  n_ti.text=cNote.title
  n_te.text=cNote.text
  n_auth.text=cNote.auth
  n_le.text=cNote.le
end

function love.mousereleased(x,y,btn)
  if btn==1 then
    Display.clicks(x,y)
  end
end

function notesroom:keypressed(k)
  love.event.quit()
end

function notesroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end


return notesroom
