local notesroom={}
local ac="none"
local acb="none"

function notesroom:enter()
  Display.clear()
  Data.readNotes()
  love.graphics.setBackgroundColor({252, 250, 204,255})
  Display.setActiveButton("none")
  cNote.title="No note chosen."
  cNote.text=" "
  cNote.auth=" "
  cNote.le=" "
  Display.create("menu","Menu",{255,100,100,255},{255,200,200,255},{0,0,0,255},ww,30,100,20,14,"fill",{"lo=LOG OUT","ex=EXIT"})
  Display.create("simpbox","tbar",{255,150,150,255},{255,150,150,255},{255,255,255,255},0,0,love.graphics.getWidth(),30,20,"fill","NOTES")
  Display.create("simpbox","n_p",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,30,love.graphics.getWidth()/2,love.graphics.getHeight()-30,16,"fill","Note preview")
  Display.create("simpbox","n_ti",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,30,love.graphics.getWidth()/2,50,16,"fill",cNote.title)
  Display.create("simpbox","n_te",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,80,love.graphics.getWidth()/2,love.graphics.getHeight()/2,16,"fill",cNote.text)
  Display.create("simpbox","n_auth",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,love.graphics.getHeight()/2+50,love.graphics.getWidth()/2,50,16,"fill",cNote.auth)
  Display.create("simpbox","n_le",{255,255,255,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,love.graphics.getHeight()/2+100,love.graphics.getWidth()/2,500,16,"fill",cNote.le)
  Display.create("button","tm",{255,100,100,255},{255,255,255,255},{255,255,255,255},love.graphics.getWidth()-30,0,30,30,30,"fill","--")
  Display.create("button","e_n",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2,love.graphics.getHeight()/2+150,100,30,16,"fill","Edit")
  Display.create("button","d_n",{255,100,100,255},{255,255,255,255},{0,0,0,255},love.graphics.getWidth()/2+110,love.graphics.getHeight()/2+150,100,30,16,"fill","Delete")
end

function notesroom:update(dt)
  ww=love.graphics.getWidth()
  wh=love.graphics.getHeight()
  posx,posy=love.mouse.getPosition()
  Display.update(dt)
  ac=Display.getActiveOption("Menu")
  acb=Display.getActiveButton()

  if acb~="none" and ac~="lo" then

    if acb=="tm" or ac=="ex" or ac=="nn" then
      Display.tofront("Menu")
        Display.slide("Menu",ww-100,2)
    end

    if ac=="ex" then
      love.event.quit()
    end

    if acb=="d_n" and cNote.title~="No note chosen." then
      Display.setActiveButton("none")
      Gamestate.switch(deleteroom)
      return
    end

    if buttons[acb].type=="note" then
      cNote.title=acb
      cNote.text=notes[acb].text
      cNote.auth=notes[acb].auth
      cNote.le=notes[acb].lastedit
      Display.setActiveButton("none")
      Display.setVal("n_ti",cNote.title)
      Display.setVal("n_te",cNote.text)
      Display.setVal("n_auth",cNote.auth)
      Display.setVal("n_le",cNote.le)
    elseif acb=="e_n" and cNote.title~="No note chosen." then
        Display.setActiveButton("none")
        Gamestate.switch(editroom)
    else
      cNote.title="No note chosen."
      cNote.text=" "
      cNote.auth=" "
      cNote.le=" "
      Display.setVal("n_ti",cNote.title)
      Display.setVal("n_te",cNote.text)
      Display.setVal("n_auth",cNote.auth)
    end
  else
    Display.slide("Menu",ww,2)
  end

  if ac == "lo" then
    Display.setActiveButton("none")
    ac=nil
    Gamestate.switch(LP)
    return
  end

  if acb=="new_note" then
    Data.addN("New note","Text goes here",cLog.user,cLog.user)
    Gamestate.switch(editroom)
    return
  end


end

function love.mousereleased(x,y,btn)
  if btn==1 then
    Display.clicks(x,y)
  end
end

function notesroom:draw()
  Display.all()
  love.graphics.setColor({255,255,255,255})
  love.graphics.draw(cursor,posx,posy)
end


return notesroom
