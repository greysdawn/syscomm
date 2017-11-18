Display={}
boxes={}
buttons={}
menus={}
lb={}
rb={}
time=0

--create box that shows text
function Display.create_simpbox(name,bcolor,acolor,tcolor,x,y,width,height,tsize,type,text,hid)
  boxes[name]={}
  --active color
  boxes[name].acolor=acolor
  --box background/line color
  boxes[name].boxcolor=bcolor
  --text color
  boxes[name].textcolor=tcolor
  boxes[name].h=height
  boxes[name].w=width
  boxes[name].x=x
  boxes[name].y=y
  --text size
  boxes[name].tsize=tsize or 16
  --fill or line mode
  boxes[name].type=type or "fill"
  --the text for it
  boxes[name].text=text or ""

  --active? not active? default: not active
  boxes[name].active=false

  boxes[name].hidden=hid or false
end

--create input box
function Display.create_ibox(name,bcolor,acolor,tcolor,x,y,width,height,tsize,type,text,hid)
  boxes[name]={}
  --active color
  boxes[name].acolor=acolor
  --box color
  boxes[name].boxcolor=bcolor
  --text color
  boxes[name].textcolor=tcolor
  boxes[name].h=height
  boxes[name].w=width
  boxes[name].x=x
  boxes[name].y=y
  --text
  boxes[name].text=text or ""
  --individual character
  boxes[name].chars={}
  --used later
  boxes[name].tempchars={}
  --text size
  boxes[name].tsize=tsize or 16
  --mode of drawing
  boxes[name].type=type or "fill"
  --used later
  boxes[name].temptext=text or ""
  --used later
  boxes[name].t=0
  --not active on creation
  boxes[name].active=false

  boxes[name].hidden=hid or false
end

function Display.create_button(name,bcol,acol,tcol,x,y,width,height,text,tsize,mode,hid)
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
  buttons[name].text=text
  --text size
  buttons[name].tsize=tsize or 16
  --draw mode
  buttons[name].mode=mode or "fill"
  --not active
  buttons[name].active=false

  buttons[name].hidden=hid or false
end

--this one's complicated
--okay so basically this one takes a table, btns, as an argument
function Display.create_menu(name,btns,bcol,acol,tcol,x,y,width,height,tsize,mode,hid)
  menus[name]={}
  menus[name].buttons={}
  menus[name].height=30
  menus[name].width=width
  menus[name].color=bcol
  menus[name].tcolor=tcol
  menus[name].x=x
  menus[name].y=y
  menus[name].tsize=tsize or 16
  menus[name].mode=mode or "fill"
  menus[name].hidden=hid or false
  for i,v in pairs(btns) do --i is the button name, v is the button text, so, btns should look like {"mbtn1"="text"}
    Display.create_button(i,bcol,acol,tcol,x+10,y+menus[name].height,width-20,height,v,menus[name].tsize,menus[name].mode)
    table.insert(menus[name].buttons,i)
    menus[name].height=menus[name].height+height+10
  end
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
        love.graphics.setColor(boxes[name].boxcolor) --otherwise draw it as the default color
      end

      love.graphics.rectangle(boxes[name].type,boxes[name].x,boxes[name].y,boxes[name].w,boxes[name].h) --draw it
      love.graphics.setColor(boxes[name].textcolor) --set it to the text color
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
      love.graphics.rectangle(menus[name].mode,menus[name].x,menus[name].y,menus[name].width,menus[name].height)
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
    Display.setActiveBox(box) --make that thing active
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
    Display.setActiveButton(b)--set active
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

function Display.getVal(box)
  if boxes[box]~=nil then
    return boxes[box].text
  else
    error("Box "..box.." is not a valid box.")
  end
end

--change the box color
function Display.changeboxcolor(box,color)
  boxes[box].boxcolor=color
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

function Display.delete_box(box)
  boxes[box]={}
end

function Display.delete_button(button)
  buttons[button]={}
end

function Display.notes_menu()
end

function Display.edit_menu()
end

function Display.notelist()
end

function Display.notepage()
end

return Display