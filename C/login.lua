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
      cLog.user=name
      cLog.pass=pass
       if not love.filesystem.exists("confs.data") then
          love.filesystem.write("confs.data","name;;"..name.."\n252,250,204,255\n255,255,255,255\n0,0,0,255\n")
        end
        Data.readConfs()
        if not confs[name] then
          Data.addConf(name,{"252,250,204,255","255,255,255,255","0,0,0,255"})
          Data.readConfs()
        end
      Gamestate.switch(notesroom)
    else
      er3:show()
    end
  end

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
        cLog.user=name
        cLog.pass=pass
        if not love.filesystem.exists("confs.data") then
          love.filesystem.write("confs.data","name;;"..name.."\n252,250,204,255\n255,255,255,255\n0,0,0,255\n")
        end
        Data.readConfs()
        if not confs[name] then
          Data.addConf(name,{"252,250,204,255","255,255,255,255","0,0,0,255"})
          Data.readConfs()
        end
        Gamestate.switch(notesroom)
      else
        er2:show()
      end
    else
      er1:show()
    end
  end
end

return Login
