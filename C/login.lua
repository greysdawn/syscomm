--code behind logging in

Login={}
logins={}
log_parse={}

li=false

function Login.register(name,pass)
  Save.readLog()
  local x=1
  local fnd=false
  if #boxes["usn"].chars>0 and #boxes["pas"].chars>0 then
    while x<=#logsdat do
      if logsdat[x].un==name then
        fnd=true
        break
      else
        x=x+1
      end
    end

    if not fnd then
      local logs={}
      table.insert(logs,name.."|"..pass)
      Save.prepLogs(logs)
      Save.saveL()
      Gamestate.switch(testroom)
    else
      Display.showbox("er3")
    end
  end
end

function Login.lkeys(k)
  local abox=Display.getActiveBox()
  if k == "tab" then
    if abox=="usn" then
      Display.setActiveBox("pas")
    elseif abox=="pas" then
      Display.setActiveBox("usn")
    end
  end

  if k == "return" and #boxes["usn"].chars>0 and #boxes["pas"].chars>0 then
    Display.setActiveButton("log")
  end
end

function Login.login(name,pass)
  Save.readLog()
  local x=1
  local fnd=false
  if #boxes["usn"].chars>0 and #boxes["pas"].chars>0 then
    while x<=#logsdat do
      if logsdat[x].un==name then
        fnd=true
        break
      else
        x=x+1
      end
    end

    if fnd then
      if logsdat[x].p==pass then
        Gamestate.switch(testroom)
      else
        Display.showbox("er2")
      end
    else
      Display.showbox("er1")
    end
  end
end

return Login
