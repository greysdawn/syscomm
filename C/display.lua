Display={}
z={}
cNote={}

Object={
  fetchcode="",
  x=0,
  y=0,
  w=0,
  h=0,
  c={255,255,255,255},
  tc={0,0,0,255},
  ts=16,
  text="test",
  mode="fill",
  hidden=false,
  active=false,
  type=""
}

function Object:new(o)
  local o=o or {}
  setmetatable(o,self)
  self.__index=self
  if self.fetchcode~="" then
    table.insert(z,self.fetchcode)
  end
  return o
end

SBox=Object:new{type="sbox"}


function SBox:draw()
  love.graphics.setNewFont(self.ts)
  love.graphics.setColor(self.c)
  love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
  love.graphics.setColor(self.tc)
  love.graphics.printf(self.text,self.x,self.y,self.w)
end

function SBox:setText(text)
  self.text=text
end

Button=Object:new{c2={255,255,255,255},type="regbutton"}

function Button:draw()
  love.graphics.setNewFont(self.ts)
  if self.active then
    love.graphics.setColor(self.c2)
  else
    love.graphics.setColor(self.c)
  end
  love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
  love.graphics.setColor(self.tc)
  love.graphics.printf(self.text,self.x,self.y,self.w)
end

function Button:setActive(val)
  self.active=val
end

IBox=Object:new{chars={},tchars={},ttext="",time=0,type="ibox"}

function IBox:draw()
  love.graphics.setNewFont(self.ts)
  if self.active then
    love.graphics.setColor(self.c2)
  else
    love.graphics.setColor(self.c)
  end
  love.graphics.rectangle(self.mode,self.x,self.y,self.w,self.h)
  love.graphics.setColor(self.tc)
  love.graphics.printf(self.text,self.x,self.y,self.w)
end

function Display.create(type,name,bcol,acol,tcol,x,y,width,height,tsize,mode,b_t,hid,max)
  if type=="menu" then
    menus[name]={}
    menus[name].buttons={}
    menus[name].h=tsize+30
    menus[name].w=width
    menus[name].color=bcol
    menus[name].tcolor=tcol
    menus[name].x=x
    menus[name].y=y
    menus[name].tsize=tsize or 16
    menus[name].mode=mode or "fill"
    menus[name].hidden=hid or false
    table.insert(z,name)
    for i,v in ipairs(b_t) do
      local mbti=""
      local mbte=""
      local sep=false
      for c in v:gmatch(".") do
        if c~="=" then
          if not sep then
            mbti=mbti..c
          else
            mbte=mbte..c
          end
        else
          sep=true
        end
      end
      Display.create("button",mbti,bcol,acol,tcol,x,y+menus[name].h+((height+10)*#menus[name].buttons),width,height,menus[name].tsize,menus[name].mode,mbte,hid)
      table.insert(menus[name].buttons,mbti)
      --menus[name].h=menus[name].h+height+10
    end
    menus[name].h=menus[name].h+((height+10)*#menus[name].buttons)

  elseif type=="notebutton" then
    buttons[name]={}
    --active color
    buttons[name].acolor=acol
    --button color
    buttons[name].bcolor=bcol
    --text color
    buttons[name].tcolor=tcol
    buttons[name].x=x
    buttons[name].y=y
    buttons[name].w=width
    buttons[name].h=height
    --text
    buttons[name].text=b_t
    --text size
    buttons[name].tsize=tsize or 16
    --draw mode
    buttons[name].mode=mode or "fill"
    --not active
    buttons[name].active=false

    buttons[name].hidden=hid or false
    buttons[name].type="note"
    table.insert(z,name)
  elseif type=="ibox" then
    boxes[name]={}
    --active color
    boxes[name].max=max or 20
    boxes[name].type=type
    boxes[name].acolor=acol
    --box color
    boxes[name].bcolor=bcol
    --text color
    boxes[name].tcolor=tcol
    boxes[name].h=height
    boxes[name].w=width
    boxes[name].x=x
    boxes[name].y=y
    --text
    boxes[name].text=b_t or ""
    --individual character
    boxes[name].chars={}
    --used later
    boxes[name].tempchars={}
    --text size
    boxes[name].tsize=tsize or 16
    --mode of drawing
    boxes[name].mode=mode or "fill"
    --used later
    boxes[name].temptext=b_t or ""
    --used later
    boxes[name].t=.125
    --not active on creation
    boxes[name].active=false

    boxes[name].hidden=hid or false

    if boxes[name].text ~= "" then
      for c in boxes[name].text:gmatch(".") do
        boxes[name].chars[#boxes[name].chars+1]=c
      end
      boxes[name].tempchars=boxes[name].chars
    end
    table.insert(z,name)
  end
end

function Display.menu(name)
  love.graphics.setColor(menus[name].color)
  love.graphics.rectangle(menus[name].mode,menus[name].x,menus[name].y,menus[name].w,menus[name].h)
  love.graphics.setColor(menus[name].tcolor)
  love.graphics.line(menus[name].x+1,menus[name].y+30,menus[name].x+menus[name].w-1,menus[name].y+30)
  love.graphics.setNewFont(menus[name].tsize)
  love.graphics.setColor(menus[name].tcolor)
  love.graphics.print(name,menus[name].x,menus[name].y)
  for i,v in ipairs(menus[name].buttons) do
    buttons[v].x=menus[name].x
    buttons[v].y=menus[name].y+menus[name].tsize+((buttons[v].h+10)*i)
    buttons[v].w=menus[name].w
    buttons[v].hidden=false
  end
end
--do the text things for input boxes
function Display.ib_text(k,b)
  if boxes[b].active and k:match("[A-Za-z0-9!-~ ]") then --if the box is active and the key is a letter or number
    if #boxes[b].chars<boxes[b].max then --and the number of characters in the box is less than the max
      boxes[b].chars[#boxes[b].chars+1]=k --add to the characters
    end
  end

end

--update text boxes
function Display.ibox_upd(dt,box)
  --if the button is clicked on
  if love.mouse.isDown(1) and posx>=boxes[box].x and posx<=boxes[box].x+boxes[box].w and posy>=boxes[box].y and posy<=boxes[box].y+boxes[box].h and not boxes[box].hidden then
    boxes[box].active=true --make that thing active
  elseif love.mouse.isDown(1) and not (posx>=boxes[box].x and posx<=boxes[box].x+boxes[box].w and posy>=boxes[box].y and posy<=boxes[box].y+boxes[box].h and not boxes[box].hidden) then
    boxes[box].active=false
  end

  if boxes[box].hidden then
    boxes[box].active=false
  end

  --compare the size of chars and tempchars, then concat all chars and set it as the text
  if not (#boxes[box].tempchars<#boxes[box].chars) then --this seems to work best? still not sure why
    boxes[box].temptext="" --reset the temptext
    for ch in pairs(boxes[box].chars) do --for every character in it
      boxes[box].temptext=boxes[box].temptext..boxes[box].chars[ch] --concat all chars into the temporary text var
    end
    boxes[box].tempchars=boxes[box].chars --reset the tempchars
  end

  boxes[box].t=boxes[box].t+dt --time variable! Remember this?

  if love.keyboard.isDown("backspace") and boxes[box].active then --if backspace is being held down
    if boxes[box].t>=.075 then --if the time is greater than .125
      if #boxes[box].chars>0 then --and there are things to delete
        boxes[box].chars[#boxes[box].chars]=nil --delete the last one
        boxes[box].t=0 --reset the time
      end
    end
  else
    boxes[box].t=.075
  end

  boxes[box].text=boxes[box].temptext --set the text once you're done
end


function Display.slide(obj,newx,time)
  if menus[obj] then
    if menus[obj].x~=newx then
      menus[obj].x=menus[obj].x+(newx-menus[obj].x)/time

  --    for i,v in pairs(menus[obj].buttons) do
  --      buttons[v].x=buttons[v].x+math.floor((newx-buttons[v].x)/time)
  --    end
    end
  end
end

function Display.drop(obj,newy,time)
  if menus[obj] then
    if menus[obj].y~=newy then
      menus[obj].y=menus[obj].y+(newy-menus[obj].y)/time
    end
  end
end

function Display.clicks(x,y)
  for i,v in ipairs(z) do
    if buttons[v] then
      Display.button_upd(v,x,y)
    end
  end
end

return Display
