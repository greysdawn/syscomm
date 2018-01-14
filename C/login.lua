--code behind logging in

Login={}
cLog={}

function Login.register(name,pass)
  Data.readLog()
  local x=1
  local fnd=false
  if #usn.chars>0 and #pas.chars>0 then
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
      table.insert(logs,Data.encrypt(name).."|"..Data.encrypt(pass))
      Data.prepLogs(logs)
      Data.saveL()
      Gamestate.switch(notesroom)
    else
      er3:show()
    end
  end

  cLog.user=name
  cLog.pass=pass
end

function Login.login(name,pass)
  Data.readLog()
  local x=1
  local fnd=false
  if #usn.chars>0 and #pas.chars>0 then
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
        Gamestate.switch(notesroom)
      else
        er2:show()
      end
    else
      er1:show()
    end
  end

  cLog.user=name
  cLog.pass=pass
end

return Login
