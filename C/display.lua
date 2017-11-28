Display={}
boxes={}
buttons={}
menus={}
windows={}
lb={}
rb={}
time=0

function Display.create(type,name,bcol,acol,tcol,x,y,width,height,tsize,mode,b_t,hid)
  if type=="menu" then
    menus[name]={}
    menus[name].buttons={}
    menus[name].h=30
    menus[name].w=width
    menus[name].color=bcol
    menus[name].tcolor=tcol
    menus[name].x=x
    menus[name].y=y
    menus[name].tsize=tsize or 16
    menus[name].mode=mode or "fill"
    menus[name].hidden=hid or false
    for i,v in pairs(b_t) do --i is the button name, v is the button text, so, btns should look like {mbtn1="text"}
      Display.create("button",i,bcol,acol,tcol,x+10,y+menus[name].h,width-20,height,menus[name].tsize,menus[name].mode,v)
      table.insert(menus[name].buttons,i)
      menus[name].h=menus[name].h+height+10
    end
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
  elseif type=="ibox" then
    boxes[name]={}
    --active color
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
    boxes[name].t=0
    --not active on creation
    boxes[name].active=false

    boxes[name].hidden=hid or false
  elseif type=="simpbox" then
    boxes[name]={}
    --active color
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
  end
end

function Display.create_window(name,bcol,ocol,tcol,x,y,w,h,hid)
  windows[name]={}
  windows[name].bcolor=bcol or {255,255,255,255}
  windows[name].ocolor=ocol or {200,200,200,255}
  windows[name].tcolor=tcol or {255,255,255,255}
  windows[name].tsize=16
  windows[name].x=x or 0
  windows[name].y=y or 0
  windows[name].w=w or 100
  windows[name].h=h+10 or 110
  windows[name].ih=y+20
  windows[name].buttons={}
  windows[name].menus={}
  windows[name].sboxes={}
  windows[name].iboxes={}
  windows[name].hidden=hid or false
end

function Display.add(type,wind,given)
  if type=="button" then
    for i,v in pairs(given) do
      if windows[wind].ih+v[5]>=windows[wind].h then
        error("Button "..i.." set past end of window. Please move it.")
      end
      Display.create("button",i,v[1],v[2],v[3],v[4],v[5]+windows[wind].ih,v[6],v[7],v[8],v[9],v[10],v[11])
      table.insert(windows[wind].buttons,tostring(i))
    end
  end

  --if type=="menu" then
    --
  --end
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
  if boxes[name] ~= nil then --if box exists then
    if not boxes[name].hidden then
      love.graphics.setNewFont(boxes[name].tsize) --set the font to the text size

      if boxes[name].active then --if it's active...
        love.graphics.setColor(boxes[name].acolor) --draw it as the active color
      else
        love.graphics.setColor(boxes[name].bcolor) --otherwise draw it as the default color
      end

      love.graphics.rectangle(boxes[name].mode,boxes[name].x,boxes[name].y,boxes[name].w,boxes[name].h) --draw it
      love.graphics.setColor(boxes[name].tcolor) --set it to the text color
      love.graphics.print(boxes[name].text,boxes[name].x,boxes[name].y) --write the text
    end
  else
    error("Box "..name.." is not registered.") --if not found, give us a fancy error
  end
end

--same with a button
function Display.button(name)
  if buttons[name] ~= nil then
    if not buttons[name].hidden then
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
    else
      error("Button "..name.." is not registered.")
    end
end

function Display.menu(name)
  if menus[name] ~= nil then
    if not menus[name].hidden then
      love.graphics.setColor(menus[name].color)
      love.graphics.rectangle(menus[name].mode,menus[name].x,menus[name].y,menus[name].w,menus[name].h)
      love.graphics.setColor(menus[name].tcolor)
      love.graphics.print(name,menus[name].x,menus[name].y)
      for i in pairs(menus[name].buttons) do
        Display.button(menus[name].buttons[i])
      end
    end
  else
    error("Menu "..name.." not a valid menu.")
  end
end

function Display.window(name)
  if windows[name] ~= nil then
    if not windows[name].hidden then
      love.graphics.setColor(windows[name].bcolor)
      love.graphics.rectangle("fill",windows[name].x,windows[name].y,windows[name].w,windows[name].h)
      love.graphics.setColor({200,0,0,255})
      love.graphics.rectangle("fill",windows[name].x+windows[name].w-10,windows[name].y,10,10)
      love.graphics.setColor(windows[name].ocolor)
      love.graphics.setLineWidth(2)
      love.graphics.rectangle("line",windows[name].x,windows[name].y,windows[name].w,windows[name].h)
      love.graphics.setNewFont(windows[name].tsize)
      love.graphics.setColor(windows[name].tcolor)
      love.graphics.print(name,windows[name].x,windows[name].y)
      if #windows[name].buttons >0 then
        for i in pairs(windows[name].buttons) do
          Display.button(windows[name].buttons[i])
        end
      end
    end
  else
    error("Window "..name.." is not a valid window.")
  end
end

--backspaaaaaace (only for input boxes tho)
function Display.bsp(k,box)
  if k == "backspace" then --if the backspace button is pressed
    if boxes[box].active and #boxes[box].chars>0 then --and the box is active and there are characters
      boxes[box].chars[#boxes[box].chars]=nil --delete the last character
    end
  end
end

--do the text things for input boxes
function Display.ib_text(k,b,max)
  local max=max or 10 --set the max, default is 10
  if boxes[b].active and k:match("%w") then --if the box is active and the key is a letter or number
    if #boxes[b].chars<max then --and the number of characters in the box is less than the max
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
    if boxes[box].t>=.125 then --if the time is greater than .125
      if #boxes[box].chars>0 then --and there are things to delete
        boxes[box].chars[#boxes[box].chars]=nil --delete the last one
        boxes[box].t=0 --reset the time
      end
    end
  else
    boxes[box].t=0 --or just set it at 0
  end

  boxes[box].text=boxes[box].temptext --set the text once you're done
end

--update the button
function Display.button_upd(b)
  --if clicked
  if love.mouse.isDown(1) and posx>=buttons[b].x and posx<=buttons[b].x+buttons[b].w and posy>=buttons[b].y and posy<=buttons[b].y+buttons[b].h then
    buttons[b].active=true
  elseif love.mouse.isDown(1) and not (posx>=buttons[b].x and posx<=buttons[b].x+buttons[b].w and posy>=buttons[b].y and posy<=buttons[b].y+buttons[b].h) then
    buttons[b].active=false
  end
  --that's all you need
end

function Display.menu_upd(name)
  if menus[name].hidden then
    menus[name].active=false
  end
  if not menus[name].hidden then
    for i in pairs(menus[name].buttons) do
      Display.button_upd(menus[name].buttons[i])
    end
  end
end

function Display.window_upd(name)
  if love.mouse.isDown(1) and posx>=windows[name].x+windows[name].w-10 and posx<=windows[name].x+windows[name].w and posy>=windows[name].y and posy<=windows[name].y+10 then
    Display.hidewindow(name)
  end
  if not windows[name].hidden then
    if #windows[name].buttons > 0 then
      for i in pairs(windows[name].buttons) do
        Display.button_upd(windows[name].buttons[i])
      end
    end
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
function Display.changeboxcolor(box,color)
  boxes[box].bcolor=color
end

--change button color
function Display.changebuttoncolor(button,color)
  buttons[button].bcolor=color
end

function Display.clear()
  boxes={}
  buttons={}
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
end

function Display.hidewindow(w)
  windows[w].hidden=true
  for b in pairs(windows[w].buttons) do
    buttons[windows[w].buttons[b]].active=false
  end
end

function Display.delete_box(box)
  boxes[box]={}
end

function Display.delete_button(button)
  buttons[button]={}
end

function Display.notelist()
end

function Display.notepage()
end

return Display
