Save={} --creates functions object
tosaveN={} --obj for what to save
tosaveL={}
recoveredN={} --found notes
recoveredL={}
logsdat={}
notes={} --all notes
local m=1
o=1

function Save.prepNotes(tb)
  for i in ipairs(tb) do
    table.insert(tosaveN,tb[i])
  end
end

function Save.prepLogs(tb)
  for i in pairs(tb) do
    table.insert(tosaveL,tb[i])
  end
end

function Save.saveN()
  for i in ipairs(tosaveN) do
    love.filesystem.append("data.data",tosaveN[i].."\n")
  end
end

function Save.saveL()
  for i in pairs(tosaveL) do
    love.filesystem.append("logs.data",tosaveL[i].."\n")
  end
end

function Save.readNotes()
  local iny=30
  for line in love.filesystem.lines("data.data") do
    table.insert(recoveredN,line)
  end
  local e=1
  local done=false
  while e<=#recoveredN do
    charas={}
    for x in string.gmatch(recoveredN[e],".") do
      charas[#charas+1]=x
      m=1
    end
    for en in pairs(charas) do
      if charas[en]~="|" then
        m=m+1
      else
        o=m
      end
    end

    ti=string.sub(recoveredN[e],1,o-1)
    te=string.sub(recoveredN[e],o+1,#charas)
    Display.create("simpbox",ti,{255,255,255,255},{0,0,0,0},{0,0,0,255},0,iny,love.graphics.getWidth(),20,16,"fill",ti,false)
    notes[ti]=te
    e=e+1
    iny=iny+20
  end
end

function Save.readLog()
  for line in love.filesystem.lines("logs.data") do
    table.insert(recoveredL,line)
  end
  e=1
  while e<=#recoveredL do
    charas={}
    for x in string.gmatch(recoveredL[e],".") do
      charas[#charas+1]=x
      m=1
    end
    for en in pairs(charas) do
      if charas[en]~="|" then
        m=m+1
      else
        o=m
      end
    end

    ti=string.sub(recoveredL[e],1,o-1)
    te=string.sub(recoveredL[e],o+1,#charas)
    logsdat[#logsdat+1]={}
    logsdat[#logsdat].un=ti
    logsdat[#logsdat].p=te
    e=e+1
  end
end

return Save
