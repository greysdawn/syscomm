local sroom={}

function sroom:enter()
  Display.clear()
  Data.readConfs()
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  rd,gn,bl,alp=string.match(confs[cLog.user].bg,"(%d+),(%d+),(%d+),(%d+)")
  nrd,ngn,nbl,nalp=string.match(confs[cLog.user].nc,"(%d+),(%d+),(%d+),(%d+)")
  trd,tgn,tbl,talp=string.match(confs[cLog.user].tc,"(%d+),(%d+),(%d+),(%d+)")
  bg=SBox:new{c={1,1,1,1},c2={1,1,1,1},text="",x=100,y=100,w=ww-200,h=wh-200,fetchcode="bg"}
  seb=SBox:new{c={0,0,0,0},c2={0,0,0,0},tc={1,0,0,1},text="Please make sure all values are correct rgba values.",ts=18,x=120,y=120,hidden=true,w=500,h=20,fetchcode="seb"}
  seb2=SBox:new{c={0,0,0,0},c2={0,0,0,0},tc={1,0,0,1},text="",ts=18,x=120,y=150,hidden=false,w=500,h=20,fetchcode="seb2"}
  csb=SBox:new{c={200/255,1,1,1},c2={200/255,1,1,1},text="background color",x=120,y=200,w=140,h=20,fetchcode="csb"}
  rbx=IBox:new{chars={},c={200/255,200/255,200/255,1},max=3,x=300,y=200,w=50,h=20,updtext=function(self,key)
    if self.active and key:match("[0-9]") then
      if #self.chars<self.max then
        table.insert(self.chars,key)
      end
    end
  end,text=rd,fetchcode="rgx",label="red"}
  gbx=rbx:new{chars={},text=gn,x=360,fetchcode="gbx",label="green"}
  bbx=rbx:new{chars={},text=bl,x=420,fetchcode="bbx",label="blue"}
  abx=rbx:new{chars={},text=alp,x=480,fetchcode="abx",label="alpha"}

  ncsb=SBox:new{c={200/255,1,1,1},c2={200/255,1,1,1},text="note bg color",x=120,y=250,w=140,h=20,fetchcode="ncsb"}
  nrbx=rbx:new{chars={},max=3,x=300,y=250,w=50,h=20,text=nrd,fetchcode="nrgx",label="red"}
  ngbx=nrbx:new{chars={},text=ngn,x=360,fetchcode="ngbx",label="green"}
  nbbx=nrbx:new{chars={},text=nbl,x=420,fetchcode="nbbx",label="blue"}
  nabx=nrbx:new{chars={},text=nalp,x=480,fetchcode="nabx",label="alpha"}

  tcsb=SBox:new{c={200/255,1,1,1},c2={200/255,1,1,1},text="note text color",x=120,y=300,w=140,h=20,text="note text color",fetchcode="tcsb"}
  trbx=rbx:new{chars={},max=3,x=300,y=300,w=50,h=20,text=trd,fetchcode="trgx",label="red"}
  tgbx=trbx:new{chars={},text=tgn,x=360,fetchcode="tgbx",label="green"}
  tbbx=trbx:new{chars={},text=tbl,x=420,fetchcode="tbbx",label="blue"}
  tabx=trbx:new{chars={},text=talp,x=480,fetchcode="tabx",label="alpha"}

  ssv=Button:new{text="save",x=ww/2-150,y=350,w=50,h=20,ts=15,onclick=function()
    if not (tonumber(rbx.text)<=255 and tonumber(gbx.text)<=255 and tonumber(bbx.text)<=255 and tonumber(abx.text)<=255) then
      seb:show()
    elseif not (nrbx.text+0<=255 and ngbx.text+0<=255 and nbbx.text+0<=255 and nabx.text+0<=255) then
      seb:show()
    elseif not (trbx.text+0<=255 and tgbx.text+0<=255 and tbbx.text+0<=255 and tabx.text+0<=255) then
      seb:show()
    else
      Data.deleteConf(cLog.user)
      Data.addConf(cLog.user,{rbx.text..","..gbx.text..","..bbx.text..","..abx.text,nrbx.text..","..ngbx.text..","..nbbx.text..","..nabx.text,trbx.text..","..tgbx.text..","..tbbx.text..","..tabx.text})
      Gamestate.switch(notesroom)
    end
  end,fetchcode="ssv"}
  scn=Button:new{text="cancel",x=ww/2+100,y=350,w=50,h=20,ts=15,onclick=function()
    Gamestate.switch(notesroom)
  end,fetchcode="scn"}
end

function sroom:update(dt)
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
end

function sroom:keypressed(k)
  if k=="escape" then
    Gamestate.switch(notesroom)
  end
end

function love.mousreleased(btn,x,y)
  if btn==1 then
    Display.clicks(x,y)
  end
end

function sroom:textinput(t)
  Display.text(t)
end

function sroom:draw()
  Display.all()
  love.graphics.setColor({1,1,1,1})
  love.graphics.draw(cursor,posx,posy)
end

return sroom
