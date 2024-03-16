mod = {}

local DEFAULT_NAME = "DATA_TRACKER_BY_BOUMETY"
local saved = false

mod.init = function(self, name)
    name = name or DEFAULT_NAME
    
    if type(name) ~= "string" then
        error("'name' should be a string")
    end
    
    local data = KeyValueStore(name)
	data:Set("players", {}, function(success)
        if success then
            print("The data tracker has been set up, you can now remove this line.")
        end
	end)
end

mod.delete = function(self, name)
    name = name or DEFAULT_NAME
    
    if type(name) ~= "string" then
        error("'name' should be a string")
    end
    
    local data = KeyValueStore(name)
	data:Set("players", nil, "world", nil, function(success)
	end)
end

mod.setPlayerData = function(self, player, name)
    name = name or DEFAULT_NAME
    player = player or Player.Username
    
    if type(name) ~= "string" then
        error("'name' should be a string")
    end

    if type(player) ~= "string" then
        error("'player' should be a string")
    end

    local tracked
    local p
    local data = KeyValueStore(name)
    data:Get("players", function(success, results)
		for i=#results.players,1,-1 do
			if results.players[i].username == player then
				tracked = true
                p = i
                break
			end
		end
            
		if tracked ~= true then
			table.insert(results.players, {username = Player.Username, userID = Player.UserID, first_connection = Time.Unix(), last_connection = Time.Unix(), playtime = 0, nb = 1, average_session = 0})
			data:Set("players", results.players, function(success)
			end)
            saved = true
        else
            if saved == false then
                results.players[p].last_connection = Time.Unix()
                results.players[p].nb = results.players[p].nb + 1
                saved = true
            elseif saved == true then
                results.players[p].playtime = results.players[p].playtime + (Time.Unix() - results.players[p].last_connection)
                results.players[p].average_session = results.players[p].playtime / results.players[p].nb
            end
                
            data:Set("players", results.players, function(success)
			end)
		end
	end)
end

mod.getPlayerData = function(self, player, callback, name)
    name = name or DEFAULT_NAME

    if type(player) ~= "string" then
        error("'player' should be a string")
    end

    if type(callback) ~= "function" then
        error("'callback' should be a function")
    end
    
    if type(name) ~= "string" then
        error("'name' should be a string")
    end

    if type(player) ~= "string" then
        error("'player' should be a string")
    end

    local tracked
    local p
    local d
    local data = KeyValueStore(name)
    data:Get("players", function(success, results)
		for i=#results.players,1,-1 do
			if results.players[i].username == player then
				tracked = true
                p = i
                break
			end
		end
            
		if tracked == true then
			callback(results.players[p])
        else
            warning("'" .. name .. "'" .. " has never joined your world")
		end
	end)
end

mod.getAllData = function(self, callback, name)
    name = name or DEFAULT_NAME

    if type(callback) ~= "function" then
        error("'callback' should be a function")
    end
    
    if type(name) ~= "string" then
        error("'name' should be a string")
    end

    local d
    local data = KeyValueStore(name)
    data:Get("players", function(success, results)
		callback(results.players)
	end)
end

return mod
