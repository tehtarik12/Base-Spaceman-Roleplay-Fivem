cfg = {
    esxLegacy = true,

    PedList = {
        'a_m_m_farmer_01',
        'a_m_m_prolhost_01',
        'a_m_m_hillbilly_01',
    },

    blip = {
        ['tree'] = {
            process = vector3(-532.4026, 5372.9463, 70.4479),
            processname = '[2]Proses Batang Kayu',
            process2 = vector3(-503.6295, 5277.6777, 80.6101),
            processname2 = '[3]Mengemas Potongan Kayu',
            blip = vector3(-510.4393, 5466.5684, 76.8276),
            blipname = "[1]Mengambil Batang Kayu",
        },

        ['stone'] = {
            process = vector3(293.9971, 2865.6853, 43.6424),
            processname = '[2]Proses Batu Kasar',
            process2 = vector3(1108.7610, -2007.4677, 30.9033),
            processname2 = '[3]Melebur Batu Halus',
            blip = vector3(2952.435, 2790.712, 41.24316),
            blipname = "[1]Mengambil Batu Kasar",
        },

        -- ['cow'] = {
        --     process = vector3(985.1778, -2122.3357, 30.4754),
        --     processname = '[2]Proses Daging Mentah',
        --     process2 = vector3(960.2923, -2125.2009, 31.4594),
        --     processname2 = '[3]Mengemas Daging',
        --     blip = vector3(2458.1333, 4756.3159, 34.3039),
        --     blipname = "[1]Mengambil Daging Mentah",
        -- },

        ['oil'] = {
            process = vector3(2717.6125, 1426.2374, 24.4888),
            processname = '[2]Proses Minyak Mentah',
            process2 = vector3(218.2247, -3012.5610, 5.8520),
            processname2 = '[3]Mengemas Minyak Mentah',
            blip = vector3(440.5954, 2916.4771, 40.1167),
            blipname = "[1]Mengambil Minyak Mentah",
        },

        
        ['tailor'] = {
            process = vector3(717.1011, -962.3214, 30.5953),
            processname = '[2]Proses Kapas',
            process2 = vector3(712.92, -970.58, 30.39),
            processname2 = '[3]Menjahit Pakaian',
            blip = vector3(2639.1123, 4702.6128, 35.2654),
            blipname = "[1]Mengambil Kapas",
        },

        -- ['padi'] = {
        --     process = nil,
        --     processname = nil,
        --     process2 = nil,
        --     processname2 = nil,
        --     blip = vector3(2242.6528, 5071.3813, 46.625),
        --     blipname = "[1]Kebun Padi",
        -- },

        -- ['jeruk'] = {
        --     process = nil,
        --     processname = nil,
        --     process2 = nil,
        --     processname2 = nil,
        --     blip = vector3(2354.9868, 4744.5879, 34.3690),
        --     blipname = "[1]Kebun Jeruk",
        -- },
		
        -- ['ubi'] = {
        --     process = nil,
        --     processname = nil,
        --     process2 = nil,
        --     processname2 = nil,
        --     blip = vector3(2538.5693, 4810.2466, 33.7287),
        --     blipname = "[1]Kebun Ubi",
        -- },

        -- ['farmer'] = {
        --     process = vector3(-174.7084, 6170.5063, 31.2064),
        --     processname = "[2]Proses Bahan Tani",
        --     process2 = nil,
        --     processname2 = nil,
        --     blip = nil,
        --     blipname = nil,
        -- },

        ['sell'] = {
            selllocation = {
                ['paketanpapan'] = {vector3(1233.046, -3142.338, 7.088623), 272.126, 'Penjualan Paketan Kayu'},
                ['paketanpakaian'] = {vector3(1232.149, -3168.396, 7.088623),  274.9606, 'Penjualan Paketan Pakaian'},
                ['MINER'] = {vector3(1233.059, -3148.971, 7.088623), 272.126, 'Penjualan Hasil Tambang'},
                ['SAMPAH'] = {vector3(1232.545, -3135.877, 7.088623), 274.9606, 'Penjualan Sampah'},
                ['paketanminyak'] = {vector3(1232.624, -3155.684, 7.088623), 272.126, 'Penjualan Paketan Minyak'},
                -- ['FARMER'] = {vector3(1232.255, -3162.699, 7.088623), 274.9606, 'Penjualan Hasil Tani'},
            },
            blip = vector3(1241.314, -3152.083, 5.521606),
            blipname = "[4] Penjualan Hasil Disnaker",
        },

        
    },

    price = {
        ['tembaga'] = 200,
        ['besi'] = 350,
        ['emas'] = 600,
        ['berlian'] = 1800,
        ['kaca'] = 3000 ,
        ['scrap'] = 2000,
        ['plastik'] = 1000,
        ['paketanpapan'] = 600,
        ['paketanminyak'] = 2000,
        ['paketanpakaian'] = 450,
    },

    translation = {
        ['farmer'] = "Mengemas Bahan Tani [E]",
        ['tree'] = "Proses Kayu [E]",
        ['oil'] = "Proses Minyak [E]",
        ['cow'] = "Proses Daging [E]",
        ['cow2'] = "Mengemas Daging [E]",
        ['stone'] = "Cuci Batu [E]",
        ['tailor'] = "Proses Wol [E]",
        ['tailor2'] = "Proses Pakaian [E]",
        ['noitems'] = "Kamu Tidak Punya Bahan Mentah",
        ['limit'] = "Tas Kamu Penuh",
    },
}

Notify = function(msg)
    ESX.ShowNotification(msg)
end