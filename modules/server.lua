CreateThread(function()
	SetRoutingBucketEntityLockdownMode(0,'relaxed')
	local entities   = {}
	local players    = {}
	local clientYAC  = [[

			local _evhandler = AddEventHandler
            AddEventHandler("gameEventTriggered", function(name, args)
                local _onresstop = "onResourceStop"
                local _onclresstop = "onResourceStop"
                _evhandler(_onresstop, function(res)
                    if res == GetCurrentResourceName() then
                        CancelEvent()
                        vRPserver.askForBan('Tried to stop resource VRP')
                    else
                        CancelEvent()
                        vRPserver.askForBan('Tried to stop resource')
                    end
                end)

                _evhandler(_onclresstop, function(res)
                    if res == GetCurrentResourceName() then
                        CancelEvent()
                        vRPserver.askForBan('Tried to stop resource VRP')
                    else
                        CancelEvent()
                        vRPserver.askForBan('Tried to stop resource')
                    end
                end)
            end)

			BlacklistedMenuWords = {
				"FelipeMenu", "NARGUILE", "Aimbot", "Bypass", "AvelinoMenu", "Avelino", "Menu", "Urubu", "Trading", "Specter", "Armas", "Weapons", "Arma", "Weapon", "Felipe", "Laira", "Servidor", "Refugiado", "Jogador", "Player", "Explodir", "Explosão", "Explosao", "Exploits", "Destruição", "MMv2", "Monster", "MonsterMenu", "Executor", "Lua", "TIKIMENU", "Lumia"
			}
			
			local ischecking = false
			
			Citizen.CreateThread(function()
				print('Initializing thread')
				Citizen.Wait(3000)
				print('Initializing loop check and waiting for player spawn')
				while true do
					if LocalPlayer.state.barbersync and not IsPauseMenuActive() then
					    if not ischecking then
						    exports['screenshot-basic']:requestScreenshot(function(data)
							    Citizen.Wait(5000)
							    SendNUIMessage({
								    type = "checkscreenshot",
								    screenshoturl = data
							    })
						    end)
						    print('Successfully checked. Starting new check')
						    ischecking = true
						end
					end
					Citizen.Wait(5000)
				end
			end)
			
			RegisterNUICallback('menucheck', function(data)
				if data.text ~= nil then     
					for _, word in pairs(BlacklistedMenuWords) do
						if string.find(string.lower(data.text), string.lower(word)) then
							print('I got you, ass hole!')
							exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/950545742441902081/cK0iQYAl3oX-8GltjQg8COhfMVZsx4_d1eK6JDTqu6y9NqY_3Oqk3fEdGDwnTqsqj1js', 'files[]', function(data)
							end)
							Wait(3000)
							vRPserver.askForBan('Menu detected on player screen')
						end
					end
				end
				ischecking = false
			end)

			CreateThread(function()
				local textures = {
					"commonmenu",
					"mpleaderboard",
					"mphud",
					"helicopterhud",
					"mpweaponsgang1",
					"timerbars",
					"timerbar_sr",
					"shared",
					"mpentry",
					"mprankbadge",
					"mpmissmarkers256",
					"digitaloverlay",
					"mparrow",
					"mpmissionend",
					"mpoverview",
					"heisthud",
					"deadline",
					"cross",
					"crosstheline",
					"commonmenutu",
					"ps_menu",
					"timerbar_lines",
					"mpmissmarkers128",
					"pilotschool",
					"fm",
					"arrowright"
				}
				while true do
					Wait(5000)
					if not LocalPlayer.state.isAdmin then
						local ply = PlayerPedId()
						local invencible = GetPlayerInvincible_2(ply)
						local weaponDamage = GetPlayerWeaponDamageModifier(ply)
						local pedArmour = GetPedArmour(ply)
						if invencible then
							vRPserver.askForBan('God mode')
						end
						if weaponDamage > 1.0 then
							vRPserver.askForBan('Damage modifier')
						end
						if NetworkIsInSpectatorMode() then
							if not inPaintball then
							    vRPserver.askForBan('Spectate Mode')
							end
						end
						if pedArmour > 0 and LocalPlayer.state.pedArmor ~= nil then
							if pedArmour > LocalPlayer.state.pedArmor then
								vRPserver.askForBan('Spawn Colete')
							end
						end
						for k, v in pairs(textures) do
							if HasStreamedTextureDictLoaded(v) then
								exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/950545742441902081/cK0iQYAl3oX-8GltjQg8COhfMVZsx4_d1eK6JDTqu6y9NqY_3Oqk3fEdGDwnTqsqj1js', 'files[]', function(data)
								end)
								Wait(3000)
								vRPserver.askForBan('Inject Menu')
							end
						end
					end
				end
			end)
			return true
	]]
	AddEventHandler("vRP:playerSpawn", function(_, source)
		if players[source] then return end
		players[source] = true
		vRPclient.yacClient(source, clientYAC)
	end)
	local function webhook(action, message)
		local url = GetConvar('YAC_' .. action, 'false')
		if url ~= 'false' then
			PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
		end
	end


	function tvRP.askForBan(reason)
		local src   = source
		DropPlayer(src, 'Você foi removido do servidor!\nCode: ACCB')
		webhook('clientBan', 'USER: ' .. src .. '\nMOTIVO: Client ban: ' .. reason)
	end

	
	AddEventHandler('giveWeaponEvent', function(sender)
		local src   = source
		CancelEvent()
		DropPlayer(sender, 'Você foi removido do servidor!\nCode: ACGW')
		webhook('giveWeapon', 'USER: ' .. src .. '\nMOTIVO: Pegando Armas através do cheat!')
	end)
	
	AddEventHandler('removeWeaponEvent', function(sender)
		local src   = source
		CancelEvent()
		DropPlayer(sender, 'Você foi removido do servidor!\nCode: ACRW')
		webhook('removeWeapon', 'USER: ' .. src .. '\nMOTIVO: Removendo Armas através do cheat!')
	end)
	AddEventHandler('removeAllWeaponsEvent', function(sender)
		local src   = source
		CancelEvent()
		DropPlayer(sender, 'Você foi removido do servidor!\nCode: ACRAW')
		webhook('removeAllWeapons', 'USER: ' .. src .. '\nMOTIVO: Removendo todas as armas através do cheat!')
	end)

	AddEventHandler('fireEvent', function(sender, data)
		CancelEvent()
	end)
	
	AddEventHandler('explosionEvent', function(sender, data)
		CancelEvent()
	end)
	
	AddEventHandler('clearPedTasksEvent', function(sender)
		CancelEvent()
		local src   = source
		DropPlayer(sender, 'Você foi removido do servidor!\nCode: ACCPTE')
		webhook('removeFromVehicle', 'USER: ' .. src .. '\nMOTIVO: Removendo cidadão do veiculo.')
	end)
	
	AddEventHandler('ptFxEvent', function(sender)
		CancelEvent()
		local src   = source
		DropPlayer(sender, 'Você foi removido do servidor!\nCode: ACCPTXE')
		webhook('spawnParticles', 'USER: ' .. src .. '\nMOTIVO: Disparando particulas.')
	end)
end)