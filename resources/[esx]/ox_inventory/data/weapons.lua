return {
	Weapons = {
		['WEAPON_APPISTOL'] = {
			label = 'AP Pistol',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo',
		},

		['WEAPON_ASSAULTRIFLE'] = {
			label = 'Assault Rifle',
			weight = 4500,
			durability = 0.03,
			ammoname = '556ammo',
		},
		
		['WEAPON_PISTOL_MK2'] = {
			label = 'Pistol MK2',
			weight = 1000,
			durability = 0.5,
			ammoname = 'ammo'
		},
		
		['WEAPON_BAT'] = {
			label = 'Bat',
			weight = 1134,
			durability = 0.1,
		},
		
		['WEAPON_PLASMAP'] = {
			label = 'Bat',
			weight = 1134,
			durability = 0.1,
			ammoname = 'ammo'
		},
		['WEAPON_BULLPUPRIFLE'] = {
			label = 'Bullpup Rifle',
			weight = 2900,
			durability = 0.03,
			ammoname = 'ammo'
		},

		['WEAPON_CROWBAR'] = {
			label = 'Crowbar',
			weight = 2500,
			durability = 0.1,
		},

		['WEAPON_DAGGER'] = {
			label = 'Dagger',
			weight = 800,
			durability = 0.1,
		},
		
		['WEAPON_FIREEXTINGUISHER'] = {
			label = 'Fire Extinguisher',
			weight = 8616,
		},
		['WEAPON_FLASHLIGHT'] = {
			label = 'Flashlight',
			weight = 125,
			durability = 0.1,
		},

		['WEAPON_GOLFCLUB'] = {
			label = 'Golf Club',
			weight = 330,
			durability = 0.1,
		},

		['WEAPON_METALDETECTOR'] = {
			label = 'Metal Detector',
			weight = 1200,
		},
		
		['WEAPON_HEAVYPISTOL'] = {
			label = 'Heavy Pistol',
			weight = 1100,
			durability = 0.2,
			ammoname = 'ammo'
		},

		['WEAPON_HEAVYSNIPER'] = {
			label = 'Heavy Sniper',
			weight = 8000,
			durability = 0.5,
			ammoname = '300ammo'
		},

		['WEAPON_HEAVYSNIPER_MK2'] = {
			label = 'Heavy Sniper MK2',
			weight = 14000,
			durability = 0.5,
			ammoname = 'ammo'
		},

		['WEAPON_KNIFE'] = {
			label = 'Knife',
			weight = 300,
			durability = 0.1,
		},

		['WEAPON_MACHETE'] = {
			label = 'Machete',
			weight = 1000,
			durability = 0.1,
		},
		
		['WEAPON_MICROSMG'] = {
			label = 'Micro SMG',
			weight = 3000,
			durability = 0.1,
			ammoname = '9ammo'
		},

		['WEAPON_MINISMG'] = {
			label = 'Mini SMG',
			weight = 1270,
			durability = 0.05,
			ammoname = '9ammo'
		},

		['WEAPON_NIGHTSTICK'] = {
			label = 'Nightstick',
			weight = 1000,
			durability = 0.1,
		},

		['WEAPON_PETROLCAN'] = {
			label = 'Gas Can',
			weight = 12000,
		},
		
		['WEAPON_PISTOL50'] = {
			label = 'Pistol .50',
			weight = 2000,
			durability = 0.1,
			ammoname = '45ammo'
		},
		
		['WEAPON_REVOLVER'] = {
			label = 'Revolver',
			weight = 2260,
			durability = 0.1,
			ammoname = 'ammo'
		},

		['WEAPON_REVOLVER_MK2'] = {
			label = 'Revolver MK2',
			weight = 2600,
			durability = 0.1,
			ammoname = '762ammo'
		},
		
		['WEAPON_SMG_MK2'] = {
			label = 'SMG Mk2',
			weight = 2700,
			durability = 0.05,
			ammoname = 'ammo'
		},

		['WEAPON_STONE_HATCHET'] = {
			label = 'Stone Hatchet',
			weight = 800,
			durability = 0.1,
		},
		
		['WEAPON_COMBATPDW'] = {
			label = 'Combat PDW',
			weight = 2300,
			durability = 0.1,
			ammoname = '9ammo'
		},
		['WEAPON_STUNGUN'] = {
			label = 'Tazer',
			weight = 227,
			durability = 0.1,
		},

		['WEAPON_SWITCHBLADE'] = {
			label = 'Switchblade',
			weight = 300,
			durability = 0.1,
			anim = { 'anim@melee@switchblade@holster', 'unholster', 200, 'anim@melee@switchblade@holster', 'holster', 600 },
		},

		['WEAPON_WRENCH'] = {
			label = 'Wrench',
			weight = 2500,
			durability = 0.1,
		},
	},

	Components = {
		['at_flashlight'] = {
			label = 'Tactical Flashlight',
			weight = 120,
			type = 'flashlight',
			client = {
				component = {
					`COMPONENT_AT_AR_FLSH`,
					`COMPONENT_AT_AR_FLSH_REH`,
					`COMPONENT_AT_PI_FLSH`,
					`COMPONENT_AT_PI_FLSH_02`,
					`COMPONENT_AT_PI_FLSH_03`,
				},
				usetime = 2500
			}
		},
		
		['at_suppressor_light'] = {
			label = 'Suppressor',
			weight = 280,
			type = 'muzzle',
			client = {
				component = {
					`COMPONENT_AT_PI_SUPP`,
					`COMPONENT_AT_PI_SUPP_02`,
					`COMPONENT_CERAMICPISTOL_SUPP`,
					`COMPONENT_PISTOLXM3_SUPP`
				},
				usetime = 2500
			}
		},

		['at_suppressor_heavy'] = {
			label = 'Tactical Suppressor',
			weight = 280,
			type = 'muzzle',
			client = {
				component = {
					`COMPONENT_AT_AR_SUPP`,
					`COMPONENT_AT_AR_SUPP_02`,
					`COMPONENT_AT_SR_SUPP`,
					`COMPONENT_AT_SR_SUPP_03`
				},
				usetime = 2500
			}
		},
		
		['at_clip_extended_pistol'] = {
			label = 'Extended Pistol Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_PISTOL50_CLIP_02`,
				},
				usetime = 2500
			}
		},
		
		['at_scope_thermal'] = {
			label = 'Thermal Scope',
			type = 'sight',
			weight = 420,
			client = {
				component = {
					`COMPONENT_AT_SCOPE_THERMAL`
				},
				usetime = 2500
			}
		},

		['at_clip_extended_smg'] = {
			label = 'Extended SMG Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_MICROSMG_CLIP_02`,
				},
				usetime = 2500
			}
		},
	},

	Ammo = {
		['ammo-22'] = {
			label = '.22 Long Rifle',
			weight = 3,
		},

		['gaugeammo'] = {
			label = '.12 Gauge',
			weight = 15,
		},

		['762ammo'] = {
			label = '.762 Magnum',
			weight = 16,
		},

		['45ammo'] = {
			label = '.45 ACP',
			weight = 15,
		},

		['50ammo'] = {
			label = '.50 AE',
			weight = 45,
		},

		['ammo'] = {
			label = 'ammo',
			weight = 15,
		},

		['9ammo'] = {
			label = '.9mm Ammo',
			weight = 7,
		},

		['ammo-firework'] = {
			label = 'Firework',
			weight = 200,
		},

		['ammo-flare'] = {
			label = 'Flare round',
			weight = 38,
		},

		['ammo-grenade'] = {
			label = '40mm Explosive',
			weight = 400,
		},

		['300ammo'] = {
			label = '.300 BMG',
			weight = 51,
		},

		['ammo-laser'] = {
			label = 'Laser charge',
			weight = 1,
		},

		['ammo-musket'] = {
			label = '.50 Ball',
			weight = 38,
		},

		['ammo-railgun'] = {
			label = 'Railgun charge',
			weight = 150,
		},

		['556ammo'] = {
			label = '5.56x45',
			weight = 4,
		},

		['ammo-rocket'] = {
			label = 'Rocket',
			weight = 500,
		},

		['ammo-shotgun'] = {
			label = '12 Gauge',
			weight = 38,
		},

		['ammo-sniper'] = {
			label = '7.62x51',
			weight = 9,
		},

		['ammo-emp'] = {
			label = 'EMP round',
			weight = 400,
		},
	}
}