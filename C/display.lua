Display={}
z={}
cNote={}

Object={
  fetchcode="",
  type="",
  x=0,
  y=0,
  w=0,
  h=0,
  c={1,1,1,1},
  tc={0,0,0,1},
  ts=16,
  text="test",
  mode="fill",
  hidden=false,
  active=false,
  ind=0,
  show=function(self)
    self.hidden=false
  end,
  hide=function(self)
    self.hidden=true
  end,
  xslide=function(self,newx,time)
    if self.x~=newx then
      self.x=self.x+(newx-self.x)/time
    end
  end,
  yslide=function(self,newy,time)
    if self.y~=newy then
      self.y=self.y+(newy-self.y)/time
    end
  end,
  new=function(self,o)
    local o=o or {}
    setmetatable(o,self)
    self.__index=self
    if o.fetchcode~="" then
      table.insert(z,o)
    end
    return o
  end,
  tofront=function(self)
    for i,v in ipairs(z) do
      if v.fetchcode==self.fetchcode then
        table.remove(z,i)
        table.insert(z,self)
      end
    end
  end,
  toback=function(self)
    for i,v in ipairs(z) do
      if v.fetchcode==self.fetchcode then
        table.remove(z,i)
        table.insert(z,1,self)
      end
    end
  end
}

SBox=Object:new{
  draw=function(self)
    love.graphics.setNewFont(self.ts)
    love.graphics.setColor(self.c)
    love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
    love.graphics.setColor(self.tc)
    love.graphics.printf(self.text,self.x,self.y,self.w)
  end,
  setText=function(self,text)
    self.text=text
  end,
  type="sbox"
}

Button=Object:new{
  c2={1,1,1,1},
  hc={1,200/255,200/255,1},
  draw=function(self)
    love.graphics.setNewFont(self.ts)
    if self.active then
      love.graphics.setColor(self.c2)
    elseif self.hover then
      love.graphics.setColor(self.hc)
    else
      love.graphics.setColor(self.c)
    end
    love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
    love.graphics.setColor(self.tc)
    love.graphics.printf(self.text,self.x,self.y,self.w)
  end,
  setActive=function(self,val)
    self.active=val
  end,
  click=function(self,x,y)
    if x>=self.x and x<=self.x+self.w and y>=self.y and y<=self.y+self.h then
      self.active=not self.active
    else
      self.active=false
    end
  end,
  type="button",
  update=function(self)
    if posx>=self.x and posx<=self.x+self.w and posy>=self.y and posy<=self.y+self.h then
      self.hover=true
    else
      self.hover=false
    end
    if self.active then
      self:onclick()
    end
  end,
  onclick=function()
    return
  end
}

PicButton=Button:new{
  img=love.graphics.newImage("M/settings.png"),
  new=function(self,o)
    local o=o or {}
    setmetatable(o,self)
    self.__index=self
    o.w=o.img:getWidth()
    o.h=o.img:getHeight()
    if o.fetchcode~="" then
      table.insert(z,o)
    end
    return o
  end,
  draw=function(self)
    if not self.hover then
      love.graphics.setColor({1,1,1,1})
    else
      love.graphics.setColor(self.hc)
    end
    love.graphics.draw(self.img,self.x,self.y)
  end
}

IBox=Object:new{
  c2={1,200/255,200/255,1},
  text="",
  time=.075,
  type="ibox",
  label="",
  max=10,
  draw=function(self)
    love.graphics.setNewFont(self.ts)
    if self.active then
      love.graphics.setColor(self.c2)
    else
      love.graphics.setColor(self.c)
    end
    love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
    love.graphics.setColor(self.tc)
    love.graphics.printf(self.text,self.x,self.y,self.w)
    love.graphics.printf(self.label,self.x,self.y+self.h,self.w)
  end,
  update=function(self,dt)
    posx,posy=love.mouse.getPosition()
    if love.mouse.isDown(1) and posx>=self.x and posx<=self.x+self.w and posy>=self.y and posy<=self.y+self.h and not self.hidden then
      self.active=true --make that thing active
    elseif love.mouse.isDown(1) and not (posx>=self.x and posx<=self.x+self.w and posy>=self.y and posy<=self.y+self.h and not self.hidden) then
      self.active=false
    end

    if self.hidden then
      self.active=false
    end

    self.time=self.time+dt

    if love.keyboard.isDown("backspace") and self.active then
      if self.time>=.075 then
        if #self.chars>0 then
          self.chars[#self.chars]=nil
          self.time=0
        end
      end
    else
      self.time=.075
    end
    self.text=table.concat(self.chars,"")
  end,
  updtext=function(self,key)
    if self.active and key:match("[A-Za-z0-9!-~ ]") then
      if #self.chars<self.max then
        table.insert(self.chars,key)
      end
    end
  end,
  new=function(self,o)
    local o=o or {}
    setmetatable(o,self)
    self.__index=self
    o.chars={}
    if o.text~="" then
      for char in o.text:gmatch(".") do
        table.insert(o.chars,char)
      end
    end
    if o.fetchcode~="" then
      table.insert(z,o)
    end
    return o
  end
}

Menu=Object:new{
  c2={200/255,200/255,200/255,1},
  bth=20,
  new=function(self,o,b)
    local o=o or {}
    setmetatable(o,self)
    self.__index=self
    o.btns={}
    if b~= nil then
      for i,v in ipairs(b) do
        _G[v[1]]=Button:new{c=o.c,c2=o.c2,tc=o.tc,x=o.x,y=o.y+o.h+((o.bth+10)*#o.btns),w=o.w,h=o.bth,ts=o.ts,text=v[2],hidden=o.hidden,onclick=v[3]}
        table.insert(o.btns,_G[v[1]])
      end
      o.h=o.h+((o.bth+10)*#o.btns)
    end
    if fetchcode~="" then
      table.insert(z,o)
    end
    return o
  end,
  draw=function(self)
    love.graphics.setNewFont(self.ts)
    love.graphics.setColor(self.c)
    love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
    love.graphics.setColor(self.tc)
    love.graphics.printf(self.text,self.x,self.y,self.w)
    for i,v in ipairs(self.btns) do
      v:draw()
    end
  end,
  update=function(self)
    for i,v in ipairs(self.btns) do
      v.x=self.x
      v.y=self.y+((self.bth+10)*i)
      v.hidden=self.hidden
      v.w=self.w
      v.h=self.bth
      v:update()
    end
  end,
  add=function(self,b)
    for i,v in ipairs(b) do
      _G[v[1]]=Button:new{c=self.c,c2=self.c2,tc=self.tc,x=self.x,y=self.y+self.h+((self.bth+10)*#self.btns),w=self.w,h=self.bth,ts=self.ts,text=v[2],hidden=self.hidden,onclick=v[3]}
      table.insert(self.btns,_G[v[1]])
    end
    self.h=self.h+((self.bth+10)*#b)
  end,
  type="menu"
}

function Display.update(dt)
  for i,v in ipairs(z) do
    if v.type~="sbox" then
      v:update(dt)
    end
  end
end

function Display.clicks(x,y)
  for i,v in ipairs(z) do
    if v.type=="button" then
      v:click(x,y)
    end
    if v.type=="menu" then
      for k,bt in ipairs(v.btns) do
        bt:click(x,y)
      end
    end
  end
end

function Display.text(t)
  for i,v in ipairs(z) do
    if v.type=="ibox" then
      v:updtext(t)
    end
  end
end

function Display.all()
  for i,v in ipairs(z) do
    if not v.hidden then
      v:draw()
    end
  end
end

function Display.clear()
  z={}
end

return Display
