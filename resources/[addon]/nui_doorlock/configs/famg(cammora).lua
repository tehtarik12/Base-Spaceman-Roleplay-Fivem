

-- pager depan famg
table.insert(Config.DoorList, {
	authorizedJobs = { ['famg']=0 },
	audioRemote = false,
	slides = true,
	lockpick = false,
	maxDistance = 6.0,
	doors = {
		{objHash = -43433986, objHeading = 265.0, objCoords = vector3(3114.228, 5091.448, 23.28872)},
		{objHash = -43433986, objHeading = 84.999969482422, objCoords = vector3(3115.361, 5103.91, 23.28059)}
 },
	locked = true,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})