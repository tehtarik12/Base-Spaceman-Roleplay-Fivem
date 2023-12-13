

-- PINTU DEPAN
table.insert(Config.DoorList, {
	objHash = -947252223,
	garage = false,
	objHeading = 282.041015625,
	fixText = false,
	slides = false,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['famb']=0 },
	locked = false,
	objCoords = vector3(-302.4835, 204.5178, 88.29338),
	maxDistance = 2.0,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- PINTU LIFT
table.insert(Config.DoorList, {
	objHash = -947252223,
	garage = false,
	objHeading = 280.03567504883,
	fixText = false,
	slides = false,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['famb']=0 },
	locked = true,
	objCoords = vector3(-315.2075, 211.4637, 81.92114),
	maxDistance = 2.0,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- PINTU MASUK
table.insert(Config.DoorList, {
	authorizedJobs = { ['famb']=0 },
	slides = false,
	audioRemote = false,
	lockpick = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -1675576017, objHeading = 190.00001525879, objCoords = vector3(-308.6028, 221.4221, 87.68039)},
		{objHash = 2117632351, objHeading = 188.58483886719, objCoords = vector3(-311.3867, 220.9574, 87.68117)}
 },
	locked = false,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- PINTU MASUK 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['famb']=0 },
	slides = false,
	audioRemote = false,
	lockpick = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -197147162, objHeading = 192.62481689453, objCoords = vector3(-306.2941, 207.4666, 88.43154)},
		{objHash = 368191321, objHeading = 190.9411315918, objCoords = vector3(-308.2047, 207.0839, 88.42566)}
 },
	locked = true,			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})