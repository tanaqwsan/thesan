FarmWorldID = string.upper(FarmWorldID)
StorageWorld = string.upper(StorageWorld)
StorageWorldSeedID = string.upper(StorageWorldSeedID)
PackDropWorld = string.upper(PackDropWorld)
PackDropWorldID = string.upper(PackDropWorldID)
PickaxeWorld = string.upper(PickaxeWorld)
PickaxeWorldID = string.upper(PickaxeWorldID)
bot.collect_range=2
bot.auto_collect = false
bot.auto_accept = true
bot.auto_reconnect = false
--print("start=============================")
function GonWebhook(Shinuqi)

end
function w(text)
    if logging then
        file = io.open("logs\\"..tostring(getCapitalOf(getBot().name))..".txt", "a")
        file:write(getBot():getActiveTime().."| "..getCapitalOf(getBot().name).."("..tostring(getBot():getWorld().name).."["..getx()..", "..gety().."]) : "..text.." "..(os.date("     (%d/%m/%Y & %H:%M:%S)")).."\n")
        file:close()
    end
end
function join(a,b)
    sleep(3000)
    bot:sendPacket(3,"action|join_request\nname|"..a.."|"..b.."\ninvitedWorld|0")
    sleep(6000)
    Dunyadami = tostring(world.name)
    if Dunyadami == "" or Dunyadami == "EXIT" then
        bot:sendPacket(3,"action|join_request\nname|"..a.."|"..b.."\ninvitedWorld|0")
        sleep(3000)
    end
    Reconnect("ea")
    if Dunyadami ~= "" or Dunyadami ~= "EXIT" then
        if world:getTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)).fg == 6 then
            bot:sendPacket(3,"action|join_request\nname|"..a.."|"..b.."\ninvitedWorld|0")
        end
    end
end

function warps(worldName,id)
    Reconnect("ea")
    while getBot():getWorld().name ~= worldName:upper() do
        Reconnect("ea")
        getBot():warp(worldName:upper())
        sleep(5000)
    end
    if getBot():getWorld().name == worldName:upper() then
        Reconnect("ea")
        getBot():warp(worldName:upper(),id)
        sleep(3000)
    end
end

--print("ea0")

function scanTree(id)
    countReady = 0
    countUnready = 0
   	for _, tile in pairs(world:getTiles()) do 
        if tile.fg == id and tile:canHarvest() then
            countReady = countReady + 1
        else
            countUnready = countUnready + 1
		end
    end 
    countUnready = countUnready - 3360
    return { Ready = countReady, Unready = countUnready }
end

function tarama(ids)
  fosel = 0
  for _, tile in pairs(world:getTiles()) do 
      if tile.fg == ids then 
          fosel = fosel + 1
      end
  end
  return {miktr = fosel}
end

function floats(idz)
  float = 0
  for _,obj in pairs(world:getObjects()) do 
      if obj.id == idz then 
          float = float + obj.count
      end
  end
  return {ucanlar = float}
end

function Reconnect(list)
    --Reconnect("ea")
    if bot.status ~= 1 then
        x = 7 + nil
    end
end

function harvest(list)
    rq("Harvesting..")
    Reconnect(list)
    bot.auto_collect = false
    for i, tile in ipairs(world:getTiles()) do
        Reconnect(list)
        if tile.fg == SeedID and tile:canHarvest() and tile.y < 51  then
            Reconnect(list)
            bot:findPath(tile.x,tile.y)
            bot.auto_collect = true
            sleep(delayHarvest)
            if bot.status == 1 then
                if world:getTile(tile.x,tile.y).fg == SeedID or world:getTile(tile.x,tile.y).bg == SeedID then
		    if bot:isInTile(tile.x,tile.y) then
                    	bot:hit(tile.x,tile.y)
		    else
		    	bot:findPath(tile.x,tile.y)
			sleep(delayHarvest)
			bot:hit(tile.x,tile.y)
		    end
                    sleep(delayHarvest) 
                end
            else
                Reconnect(list)
            end
            if bot.status == 1 then
                if world:getTile(tile.x,tile.y).fg == SeedID or world:getTile(tile.x,tile.y).bg == SeedID then
                    if bot:isInTile(tile.x,tile.y) then
                    	bot:hit(tile.x,tile.y)
		    else
		    	bot:findPath(tile.x,tile.y)
			sleep(delayHarvest)
			bot:hit(tile.x,tile.y)
		    end
                    sleep(delayHarvest) 
                end
            else
                Reconnect(list)    
            end
        end
        if inventory:getItemCount(BlockID) >= 150 then
            break
        end
    end
end

AgacHazir = 0
function Hazir(list)
    if world.name ~= list then
        join(list,FarmWorldID)
    end
    AgacHazir = 0
    for i, tile in ipairs(world:getTiles()) do
        if tile:canHarvest() then
            if tile.fg == SeedID or tile.bg == SeedID then
                AgacHazir = 1
            end
        end 
    end
    return AgacHazir
end

function kordinatSeed()
    return 98,53
end

function kordinatPack()
    return 98,53
end

function kordinatWind()
    return 98,53
end

function Dropf(list)
    while bot.gem_count > pricepack do
        bot:sendPacket(2, "action|buy\nitem|"..packname)
        sleep(3000) -- you can change delay
        Reconnect("ea")
    end
    if inventory:getItemCount(BlockID+1) >= 160 then
        bot.auto_collect = false
        getBot():findPath(kordinatSeed())
        w("Dropf 5")
        sleep(1000)
        getBot():findPath(kordinatSeed())
        sleep(500)
        while (inventory:getItemCount(BlockID+1) > 0) do
            sleep(500)
            bot:drop(BlockID+1, inventory:getItemCount(BlockID+1))
            sleep(800)
            getBot():say("Pinjam dlu duaratus")
            sleep(800)
            bot:moveLeft()
        end
        GonWebhook("<:botonline:1154550333398323210> GROWID : "..bot.name..
        "\n <:world:1154550372547973180> WORLD : "..world.name..
        "\n <:botlevel:1154550409344589916> LEVEL : "..bot.level..
        "\n <:seed:1154550220802240552> SEED : "..floats(BlockID+1).ucanlar..
	"\n <:wind:1154550299315404810> WIND : "..floats(WindID).ucanlar..
        "\n <:gems:994218103032520724> PACK : "..floats(PackitemID).ucanlar..
	"\n <:jam:987145988470898758> UpTime Bot : "..SecondTT(os.difftime(os.time(), startT)))
    end
    if inventory:getItemCount(WindID) >= 30 then
        bot.auto_collect = false
        getBot():findPath(kordinatWind())
        sleep(1000)
        getBot():findPath(kordinatWind())
        sleep(500)
        while (inventory:getItemCount(WindID) > 0) do
            sleep(500)
            bot:drop(WindID, inventory:getItemCount(WindID))
            sleep(800)
            getBot():say("Pinjam dlu tigaratus")
            sleep(800)
            bot:moveLeft()
        end
    end 
    if inventory:getItemCount(PackitemID) > PackDropCount then
        bot.auto_collect = false
        getBot():findPath(kordinatPack())
        sleep(1000)
        getBot():findPath(kordinatPack())
        sleep(500)
        w("Dropf 14")
        while inventory:getItemCount(PackitemID) > PackDropCount do
            sleep(500)
            bot:drop(PackitemID,inventory:getItemCount(PackitemID))
            sleep(800)
            getBot():say("Pinjam dlu patratus")
            sleep(800)
            bot:moveLeft()
        end
    end
end

function ribu(amount)
    local formatted = math.floor(amount)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end
ipBotStatus = "http://172.104.212.103/ping.php"
localip = ""
function getLocalIp()
    if localip=="" or localip:find("Bad") or localip:find("error") then
        local httpClient = HttpClient.new()
        httpClient:setMethod(Method.get)
        httpClient.url = "https://api.ipify.org"
        httpClient.headers["User-Agent"] = "Lucifer"
        local httpResult = httpClient:request()
        localip = httpResult.body
    end
    return localip
end
getLocalIp()
function rq(state)
    httpClient = HttpClient.new()
    httpClient:setMethod(Method.get)
    httpClient.url = ipBotStatus..'?growid='..getBot().name..'&world='..getBot().level.."|"..getWorld().name.."__"..tostring(ribu(getBot().gem_count))..'&ip='..getLocalIp()..'&state='..state
    httpClient.headers["User-Agent"] = "Lucifer"
    httpClient:request()
end
rq("starting..")

function TrashTheJunks()
    for i, trash in ipairs(trashList) do
        if inventory:getItemCount(trash) > WhenTrashCount then
            bot:trash(trash, inventory:getItemCount(trash))
            sleep(1000)
        end
    end
end

function plant(list)
    rq("Planting..")
    Reconnect(list)
    for i, tile in ipairs(world:getTiles()) do
		Reconnect(list)
        if bot.status == 1 and tile.y < 51  then
            if 0 == world:getTile(tile.x, tile.y).fg and 0 ~= world:getTile(tile.x, tile.y + 1).fg and world:getTile(tile.x, tile.y + 1).fg ~= SeedID and inventory:getItemCount(SeedID) > 0 then
                Reconnect(list)
                bot:findPath(tile.x,tile.y)
                sleep(PlantDelay)
                if bot:isInTile(tile.x,tile.y) then
                    bot:place(tile.x,tile.y,SeedID)
                    sleep(PlantDelay)
                else
                    bot:findPath(tile.x,tile.y)
                	sleep(PlantDelay)
                    if bot:isInTile(tile.x,tile.y) then
                        bot:place(tile.x,tile.y,SeedID)
                        sleep(PlantDelay)
                    end
                end
            end
        else
            Reconnect(list)
        end
    end
end

function tilealfg(x,y)
    Reconnect("ea")
    Reconnect("ea")
    Dunyadami = tostring(world.name)
    if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
        tilefgx = world:getTile(x,y).fg
        return {tilefg = tilefgx}
    end
end

function tilealbg(x,y)
    Reconnect("ea")
    Reconnect("ea")
    Dunyadami = tostring(world.name)
    if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
        tilebgx = world:getTile(x,y).bg
        return {tilebg = tilebgx}
    end
end


BotPxz = BotPx-1
BotPyz = BotPy-1
function PNB(list)
    rq("PNB..")
    PickaxeControl()
    Reconnect(list)
    bot.auto_collect = true
    bot:findPath(BotPxz,BotPyz)
    sleep(2000)
    while inventory:getItemCount(BlockID) > 0 do
        Reconnect(list)
        Reconnect("ea")

        if BotPxz ~= math.floor(world:getLocal().posx/32) and BotPyz ~= math.floor(world:getLocal().posy/32) then
            bot:findPath(BotPxz,BotPyz)
            sleep(2000)
            Reconnect("ea")
        end
        if tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)).tilefg == 0 then 
	if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:place(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32),BlockID)
            sleep(delayplace)
	end
        end
        if tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)+1).tilefg == 0 then
	if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:place(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)+1,BlockID)
            sleep(delayplace) 
	    end
        end
        if tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)-1).tilefg == 0 then
	if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:place(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)-1,BlockID)
            sleep(delayplace) 
	    end
        end
        while (tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)).tilefg ~= 0 or tilealbg(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)).tilebg ~= 0) do
            Reconnect(list)
            if BotPxz ~= math.floor(world:getLocal().posx/32) and BotPyz ~= math.floor(world:getLocal().posy/32) then
                bot:findPath(BotPxz,BotPyz)
                sleep(1000)
                Reconnect("ea")
            end
	    if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:hit(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)) 
            sleep(delaybreak) 
	    end
        end
        while (tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)+1).tilefg ~= 0 or tilealbg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)+1).tilebg ~= 0) do
            Reconnect(list)
            if BotPxz ~= math.floor(world:getLocal().posx/32) and BotPyz ~= math.floor(world:getLocal().posy/32) then
                bot:findPath(BotPxz,BotPyz)
                sleep(1000)
                Reconnect("ea")
            end
	    if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:hit(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)+1)
            sleep(delaybreak) 
	    end
        end
        while (tilealfg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)-1).tilefg ~= 0 or tilealbg(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)-1).tilebg ~= 0) do
            Reconnect(list)
            if BotPxz ~= math.floor(world:getLocal().posx/32) and BotPyz ~= math.floor(world:getLocal().posy/32) then
                bot:findPath(BotPxz,BotPyz)
                sleep(1000)
                Reconnect("ea")
            end
	    if bot:isInTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)) then
            bot:hit(math.floor(world:getLocal().posx/32)-1,math.floor(world:getLocal().posy/32)-1) 
            sleep(delaybreak) 
	    end
        end

    end
end

startT = os.time()
function SecondTT(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

isOwner = true




function takeP()
    for _, obj in pairs(world:getObjects()) do
      if obj.id == 98 then
        xp = math.floor(obj.x / 32)
        yp = math.floor(obj.y / 32)
        bot:findPath(xp,yp)
        sleep(1000)
        bot.auto_collect = true 
        sleep(500)
        bot.auto_collect = false
        if inventory:getItemCount(98) > 0 then
          break
        end
      end
    end
end

function dropPick()
    bot:sendPacket(2, "action|drop\n|itemID|" .. 98)
    bot:sendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" .. 98 .. "|\ncount|" .. inventory:getItemCount(98) - 1)
    sleep(1000)
end

function PickaxeControl()
    if TakePickaxe == "yes" and inventory:getItemCount(98) == 0 then
        join(PickaxeWorld,PickaxeWorldID)
        sleep(500)
        takeP()
        sleep(3000)
        if inventory:getItemCount(98) > 0 then
            bot:wear(98)
            sleep(2000)
            dropPick()
            sleep(1000)
            if inventory:getItemCount(98) > 1 then
                join(PickaxeWorld,PickaxeWorldID)
                dropPick()
                sleep(1000)
            end
            GonWebhook(bot.name.." took the pickaxe rotation starts"..
            "\n Left Pickaxe : "..floats(98).ucanlar)
        else
            GonWebhook(bot.name.." bot failed to pick up, tries again.")
            while inventory:getItemCount(98) == 0 do
                Reconnect("ea")
                sleep(5000)
                join(PickaxeWorld,PickaxeWorldID)
                sleep(500)
                takeP()
                sleep(3000)
                if inventory:getItemCount(98) > 0 then
                    bot:wear(98)
                    sleep(2000)
                    dropPick()
                    sleep(1000)
                    if inventory:getItemCount(98) > 1 then
                        join(PickaxeWorld,PickaxeWorldID)
                        dropPick()
                        sleep(1000)
                    end
                end
            end
            GonWebhook(bot.name.." took the pickaxe rotation starts"..
            "\n Left Pickaxe : "..floats(98).ucanlar)
        end
    end
    if inventory:getItemCount(98) > 1 then
        join(PickaxeWorld,PickaxeWorldID)
        dropPick()
        sleep(1000)
    end
end

PickaxeControl()

botcuk = bot.name
dinlenme = 0
function amiAdmin()
    return getBot():getWorld():hasAccess(25,25) == 1
end
function main0()
    --print("ea1")
    while isOwner == true do
        Reconnect("ea")
        --print("ea2")
        for _, list in pairs(Bots[bot.name].farmWorlds) do
            --print("ea3")
            list = string.upper(list)
            Reconnect(list)
            PickaxeControl()
            if world.name ~= list or world:getTile(math.floor(world:getLocal().posx/32),math.floor(world:getLocal().posy/32)).fg == 6 then
                join(list,FarmWorldID)
            end
            if amiAdmin() then
                --pass
            else
                --not admin here
                while not amiAdmin() do
                    Reconnect(list)
                    rq("waiting_for_acc")
                    sleep(10000)
                end
            end
            sleep(4000)
            --print("ea4")
            GonWebhook("<:botonline:1154550333398323210> NAME : "..botcuk..
            "\n <:world:1154550372547973180> WORLD : "..world.name..
            "\n <:botlevel:1154550409344589916> LEVEL : "..bot.level..
            "\n <:ready:1154561644777713675> READY   : "..scanTree(BlockID+1).Ready..
            "\n <:unready:1154561680961982495> UNREADY : "..scanTree(BlockID+1).Unready..
            "\n <:fossil:1154555048781697114> FOSSIL  : "..tarama(3918).miktr..
            "\n <:seed:1154550220802240552> SEED : "..floats(BlockID+1).ucanlar..
            "\n <:wind:1154550299315404810> WIND : "..floats(WindID).ucanlar..
            "\n <:gems:994218103032520724> PACK : "..floats(PackitemID).ucanlar..
            "\n <:jam:987145988470898758> UpTime Bot : "..SecondTT(os.difftime(os.time(), startT)))
            Hazir(list)
            --print("ea5")
            while AgacHazir == 1 do
                sleep(3000) 
                Reconnect(list)
                --print("ea6")
                if inventory:getItemCount(BlockID) <= 150 then
                    --print("ea7")
                    if world.name ~= list then
                        join(list,FarmWorldID)
                    end
                    TrashTheJunks()
                    harvest(list)
                    sleep(1000)
                end
                --print("ea8")
                if inventory:getItemCount(BlockID) >= 150 then
                    --print("eaa1")
                    if world.name ~= list then
                        --print("eaa2")
                        join(list,FarmWorldID)
                        --print("eaa3")
                    end
                    --print("eaa4")
                    TrashTheJunks()
                    --print("eaa5")
                    PNB(list)
                    --print("eaa6")
                    sleep(1000)
                end
                --print("ea9")
                if inventory:getItemCount(BlockID+1) > 0 and PLantSeed == "yes" then
                    if world.name ~= list then
                        join(list,FarmWorldID)
                    end
                    sleep(1000)
                    plant(list)
                    sleep(500)
                end
                --print("ea10")
                while bot.gem_count > pricepack do
                    Reconnect("ea")
                    bot:sendPacket(2, "action|buy\nitem|"..packname)
                    sleep(3000) -- you can change delay
                end
                --print("ea11")
                if inventory:getItemCount(PackitemID) > PackDropCount then
                    sleep(1000)
                    Dropf()
                    if world.name ~= list then
                        join(list,FarmWorldID)
                    end
                end
                --print("ea12")
                if inventory:getItemCount(BlockID+1) >= 160 then
                    sleep(500)
                    Dropf()
                    if world.name ~= list then
                        join(list,FarmWorldID)
                    end
                end
                --print("ea13")
            if inventory:getItemCount(WindID) >= 30 then
                    sleep(500)
                    Dropf()
                    if world.name ~= list then
                        join(list,FarmWorldID)
                    end
                end
                Hazir(list)
            end
            --print("ea14")
            dinlenme = dinlenme + 1
            if restBot == "yes" and dinlenme == restWorldComplete then
                getBot():say("/Dance")
                sleep(3000)
                getBot():say("Pinjam dlu seratus")
                sleep(9000)
                dinlenme = 0
                --print("ea15")
            end 
            --print("ea16")
        end
    end
end
conke = 0
menit = 35
function main()
    if pcall(main0) then
        --nothing happen
        --print("clear rotasi")
    else
        --print("error")
        rq("Bot_disconnected..")
        if bot.status ~= 1 then
            GonWebhook("Bot Offline ".."<@everyone>")
            sleep(10000)
            while bot.status ~= 1 do
                rq("Bot_reconnect.."..conke)
                bot:connect()
                sleep(60000)
                if conke == 6 then
                    rq("recon_fail,sleep_"..menit.."m.."..conke)
                    sleep(menit * 60000)
                    conke = 0
                end
                if bot.status ~= 1 then
                    --print("bot off, try reconnecting in 15s..")
                end
                conke=conke+1
            end
            sleep(5000)
            GonWebhook("Bot Back To Online ".."<@" .. YourDiscordid .. ">")
            return main()
        end
        return main()
    end
end

main()
