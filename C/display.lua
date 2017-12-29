Display={}
boxes={}
buttons={}
menus={}
z={}
cNote={}
time=0
btim=-5

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

  elseif type=="button" then
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
    buttons[name].type="reg"
    table.insert(z,name)
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
  elseif type=="simpbox" then
    boxes[name]={}
    --active color
    boxes[name].type=type
    boxes[name].acolor=acol
    --box background/line color
    boxes[name].bcolor=bcol
    --text color
    boxes[name].tcolor=tcol
    boxes[name].h=height
    boxes[name].w=width
    boxes[name].x=x
    boxes[name].y=y
    --text size
    boxes[name].tsize=tsize or 16
    --fill or line mode
    boxes[name].mode=mode or "fill"
    --the text for it
    boxes[name].text=b_t or ""

    --active? not active? default: not active
    boxes[name].active=false

    boxes[name].hidden=hid or false
    table.insert(z,name)
  end
end

function Display.createScrollBar(n,x,y,w,h,size,objects)
  bars[n]={}
  bars[n].x=x
  bars[n].bx=x
  bars[n].y=y
  bars[n].by=y
  bars[n].w=w
  bars[n].bw=w
  bars[n].h=h
  bars[n].bh=(h/size)+10
  bars[n].size=size
  bars[n].obj=objects
  bars[n].enabled=true

  table.insert(z,n)
end

function Display.setActiveButton(name)
  --set everything as false
  for k,v in pairs(buttons) do
    v.active=false
  end
  --if you want to set an actual thing...
  if name ~= "none" then
    --make that thing active
  buttons[name].active=true
  end
end

--do the same with boxes
function Display.setActiveBox(name)
  for k,v in pairs(boxes) do
    v.active=false
  end
  if name ~= "none" then
  boxes[name].active=true
  end
end

--get the active button of course
function Display.getActiveButton()
  --local active. Local means you can't access act outside of the function
  local act=""
  --loop through buttons
    for e,k in pairs(buttons) do
      --if the button is active...
      if k.active then
        --put the name of the active button in a variable
        act=e
      end
    end
  --if none are active...
  if act == "" then
    return "none" --does what it says
  else --if there is one active
    return act --does what it says
  end
end

--same with boxes
function Display.getActiveBox()
  local act=""
  for e,k in pairs(boxes) do
    if k.active then
      act=e
    end
  end
  if act == "" then
    return "none"
  else
    return act
  end
end

function Display.isButtonActive(button)
  if buttons[button].active then
    return true
  else
    return false
  end
end


function Display.getActiveOption(menu)
  local act=""
  local ab=Display.getActiveButton()
  if menu == nil then
    for i,v in menus do
      for x in v.buttons do
        if x==ab then
          act=x
        end
      end
    end
  else
    for m in pairs(menus[menu].buttons) do
      if menus[menu].buttons[m] == ab then
        act=menus[menu].buttons[m]
      end
    end
  end
  if act == "" then
    return "none"
  else
    return act
  end
end

--show a box
function Display.box(name)
      love.graphics.setNewFont(boxes[name].tsize) --set the font to the text size

      if boxes[name].active then --if it's active...
        love.graphics.setColor(boxes[name].acolor) --draw it as the active color
      else
        love.graphics.setColor(boxes[name].bcolor) --otherwise draw it as the default color
      end

      love.graphics.rectangle(boxes[name].mode,boxes[name].x,boxes[name].y,boxes[name].w,boxes[name].h) --draw it
      love.graphics.setColor(boxes[name].tcolor) --set it to the text color
      love.graphics.printf(boxes[name].text,boxes[name].x,boxes[name].y,boxes[name].w) --write the text
end

--same with a button
function Display.button(name)
      love.graphics.setNewFont(buttons[name].tsize)

      if buttons[name].active then
        love.graphics.setColor(buttons[name].acolor)
      else
        love.graphics.setColor(buttons[name].bcolor)
      end

      love.graphics.rectangle(buttons[name].mode,buttons[name].x,buttons[name].y,buttons[name].w,buttons[name].h)
      love.graphics.setColor(buttons[name].tcolor)
      love.graphics.print(buttons[name].text,buttons[name].x,buttons[name].y)
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

function Display.all()
  for i,v in ipairs(z) do
    if boxes[v] then
      if not boxes[v].hidden then
        Display.box(v)
      end
    end
    if menus[v] then
      if not menus[v].hidden then
        Display.menu(v)
      end
    end
    if buttons[v] then
      if not buttons[v].hidden then
        Display.button(v)
      end
    end
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

--update the button
function Display.button_upd(b,x,y)
  --if clicked
  -- and not (posx>=buttons[b].x and posx<=buttons[b].x+buttons[b].w and posy>=buttons[b].y and posy<=buttons[b].y+buttons[b].h)
  if x>=buttons[b].x and x<=buttons[b].x+buttons[b].w and y>=buttons[b].y and y<=buttons[b].y+buttons[b].h and not buttons[b].hidden and not buttons[b].active then
      Display.setActiveButton(b)
  elseif x>=buttons[b].x and x<=buttons[b].x+buttons[b].w and y>=buttons[b].y and y<=buttons[b].y+buttons[b].h and not buttons[b].hidden and buttons[b].active then
    Display.setActiveButton("none")
  elseif not (x>=buttons[b].x and x<=buttons[b].x+buttons[b].w and y>=buttons[b].y and y<=buttons[b].y+buttons[b].h) and not buttons[b].hidden and buttons[b].active then
    buttons[b].active=false
  end


end

function Display.menu_upd(name)
  if menus[name].hidden then
    menus[name].active=false
  end
end

function Display.update(dt)
  for i,v in ipairs(z) do
    if boxes[v] then
      if boxes[v].type=="ibox" then
      Display.ibox_upd(dt,v)
      end
    end
    if menus[v] then
      Display.menu_upd(v)
    end
  end
end

function Display.text(k)
  for i,v in ipairs(z) do
    if boxes[v] then
      if boxes[v].type=="ibox" then
        Display.ib_text(k,v)
      end
    end
  end
end

function Display.setVal(b,val)
  if boxes[b] then
    boxes[b].text=val
  end
  if buttons[b] then
    buttons[b].text=val
  end
end

function Display.getVal(box)
  if boxes[box]~=nil then
    return boxes[box].text
  else
    error("Box "..box.." is not a valid box.")
  end
end

--change the box color
function Display.changeColor(ob,color)
  if boxes[ob] then
    boxes[ob].bcolor=color
  end
  if buttons[ob] then
    buttons[ob].bcolor=color
  end
  if menus[ob] then
    menus[ob].color=color

    for i,v in pairs(menus[ob].buttons) do
      buttons[v].bcolor=color
    end
  end
end

function Display.clear()
  boxes={}
  buttons={}
  menus={}
  z={}
end

function Display.showbox(b)
  boxes[b].hidden=false
end

function Display.hidebox(b)
  boxes[b].hidden=true
end

function Display.showbutton(b)
  buttons[b].hidden=false
end

function Display.hidebutton(b)
  buttons[b].hidden=true
end

function Display.showmenu(b)
  menus[b].hidden=false
end

function Display.hidemenu(b)
  menus[b].hidden=true
  for bb in pairs(menus[b].buttons) do
    buttons[menus[b].buttons[bb]].active=false
    buttons[menus[b].buttons[bb]].hidden=true
  end
end

function Display.delete_box(box)
  boxes[box]={}
end

function Display.delete_button(button)
  buttons[button]={}
end

function Display.reorder(name,n)
  for i,v in ipairs(z) do
    if v==name then
      table.remove(z,i)
      table.insert(z,n,name)
    end
  end
end

function Display.tofront(name)
  local fnd=false
  local lp=1
  while lp<=2 do
    for i,v in ipairs(z) do
      if v==name and not fnd then
        table.remove(z,i)
        table.insert(z,name)
        fnd=true
      end

      if menus[name] and fnd then
        for e,f in ipairs(menus[name].buttons) do
          if v==f then
            table.remove(z,i)
            table.insert(z,f)
          end
        end
      end
    end
    lp=lp+1
  end
end

function Display.move(el,x,y)
  x=x or 0
  y=y or 0
  if boxes[el] then
  end
  if menus[el] then
    menus[el].x=menus[el].x+x
    menus[el].y=menus[el].y+y

  --  for i,v in pairs(menus[el].buttons) do
  --    buttons[v].x=buttons[v].x+x
  --    buttons[v].y=buttons[v].y+y
  --  end
  end
  if buttons[el] then
  end
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
