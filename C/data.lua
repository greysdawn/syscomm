Data={} --creates functions object
logsdat={}
notes_count=0

ec={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
".",",","="," ","(",")","[","]","+","_","-","*","%","^","&","!","?","<",">","@","#","$","\\",'"',"'",
"|","{","}","/","`","~",";",":","0","1","2","3","4","5","6","7","8","9"}

function Data.prepLogs(tb)
  tosaveL={}
  for i in pairs(tb) do
    table.insert(tosaveL,tb[i])
  end
end

function Data.saveN(tb)
  for i,v in ipairs(tb) do
    love.filesystem.write("data.data",v.."\n")
  end
end

function Data.alreadyExists(n)
  local alreadyexists=true
  local nnum=1
  local nti=""
  while alreadyexists do
    if nnum==1 then
      if notes[n] then
        nnum=nnum+1
      else
        nti=n
        alreadyexists=false
      end
    else
      if notes[n..nnum] then
        nnum=nnum+1
      else
        nti=n..nnum
        alreadyexists=false
      end
    end
  end
  return nti
end

function Data.addN(ti,te,auth,lasteditor)
  Data.readNotes()
  local newti=Data.alreadyExists(ti)
  cNote.title=newti
  cNote.text=te
  cNote.auth=auth
  cNote.le=lasteditor
  love.filesystem.append("data.data",Data.encrypt(newti).."|"..Data.encrypt(te).."|"..Data.encrypt(auth).."|"..Data.encrypt(lasteditor).."\n")
end

function Data.deleteN(n)
  local newtab={}
  for i,v in ipairs(notesRaw) do
    if not string.find(v,Data.encrypt(n)) then
      table.insert(newtab,v)
    end
  end
  love.filesystem.write("data.data","")
  for i,v in ipairs(newtab) do
    love.filesystem.append("data.data",v.."\n")
  end
  Data.readNotes()
end

function Data.saveL()
  for i in pairs(tosaveL) do
    love.filesystem.append("logs.data",tosaveL[i].."\n")
  end
end

function Data.readNotes()
  notes={}
  notesRaw={}
  for line in love.filesystem.lines("data.data") do
    table.insert(notesRaw,line)
  end
  local e=1
  while e<=#notesRaw do
    charas={}
    local sep=0
    local ti=""
    local te=""
    local auth=""
    local le=""
    for x in string.gmatch(notesRaw[e],".") do
      table.insert(charas,x)
      m=1
    end
    for l,v in pairs(charas) do
      if v=="|" then
        sep=sep+1
      else
        if sep==0 then
          ti=ti..v
        elseif sep==1 then
          te=te..v
        elseif sep==2 then
          auth=auth..v
        else
          le=le..v
        end
      end
    end

    ti=Data.decrypt(ti)
    te=Data.decrypt(te)
    auth=Data.decrypt(auth)
    notes[ti]={}
    notes[ti].text=te
    notes[ti].auth=auth
    notes[ti].lastedit=Data.decrypt(le)
    _G[ti]=Button:new{ntitle=ti,ntext=te,nauth=auth,nlaste=Data.decrypt(le),c={255,255,255,255},c2={255,100,100,255},x=0,y=(20*e)+10,w=love.graphics.getWidth()/2,h=20,ts=18,text=ti.." - "..auth,fetchcode=ti,onclick=function(self)
      cNote.title=self.ntitle
      cNote.text=self.ntext
      cNote.auth=self.nauth
      cNote.le=self.nlaste
    end}
    e=e+1
    notes_count=notes_count+1
  end
  new_note=Button:new{c={255,255,255,255},c2={255,100,100,255},tc={0,0,0,255},x=0,y=(20*e)+10,w=love.graphics.getWidth()/2,h=20,ts=18,text="Add new note",fetchcode="newn",onclick=function()
    cNote.title="New note"
    cNote.text="Text"
    cNote.auth=cLog.user
    cNote.le=cLog.user
    Gamestate.switch(editroom)
  end}
end

function Data.encrypt(str)
  local crypt=""
  for char in str:gmatch(".") do
    local s=1
    while s<=#ec do
      if ec[s]==char then
        if string.len(tostring(s))<2 then
          crypt=crypt.."0"..s
        else
          crypt=crypt..s
        end
        s=s+1
      else
        s=s+1
      end
    end
  end
  return crypt
end

function Data.decrypt(str)
  local crypt=""
  local bit=""
  local temp={}
  local nu=1
  for char in str:gmatch(".") do
    table.insert(temp,char)
  end
  while nu<=#temp do
    if temp[nu]~="0" then
      bit=temp[nu]..temp[nu+1]
    elseif temp[nu]=="0" then
      bit=temp[nu+1]
    else
      error(temp[nu])
    end
    if ec[tonumber(bit)] then
      crypt=crypt..ec[tonumber(bit)]
    else
      error(str)
    end

    nu=nu+2
  end
  return crypt
end

function Data.readLog()
  recoveredL={}
  for line in love.filesystem.lines("logs.data") do
    table.insert(recoveredL,line)
  end
  e=1
  while e<=#recoveredL do
    local charas={}
    local sep=0
    local ti=""
    local te=""
    for x in string.gmatch(recoveredL[e],".") do
      charas[#charas+1]=x
      m=1
    end
    for en in pairs(charas) do
      if charas[en]~="|" and sep==0 then
        ti=ti..charas[en]
      elseif charas[en]=="|" then
        sep=sep+1
      elseif charas[en]~="|" and sep==1 then
        te=te..charas[en]
      end
    end
    logsdat[#logsdat+1]={}
    logsdat[#logsdat].un=Data.decrypt(ti)
    logsdat[#logsdat].p=Data.decrypt(te)
    e=e+1
  end
end

return Data
