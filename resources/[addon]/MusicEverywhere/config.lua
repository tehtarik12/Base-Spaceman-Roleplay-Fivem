Config = {}

Config.DistanceToVolume = 30.0 -- The distance that will be with the volume at 1.0, so if the volume is 0.5 the distance will be 15.0, if the volume is 0.2 the distance will be 6.
Config.PlayToEveryone = true -- The music in car will be played to everyone? Or just for the people that are in that vehicle? If false the DistanceToVolume will not do anything
Config.ItemInVehicle = "carradio" -- Put here, if you want the radio to be an item, inside "", like "radio". With or false you will need to do /carradio
Config.CommandVehicle = "carradio" -- Only will work if Config.ItemInVehicle == false

Config.Zones = {}