Platform.create name: 'Facebook', make: 'facebook'
Platform.create name: 'Google+', make: 'google'
Platform.create name: 'Twitter', make: 'twitter'

User.create!({
               email: 'user@example.com',
               password: '123456',
               password_confirmation: '123456',
               active: true
             })


block_erupter = Miner.create!({
                name: 'ASICMiner Block Erupter USB',
                currency: 'BTC',
                price: 0.55,
                ghps: 0.3,
                power_use_watt: 3,
                availability: 'Now',
                country_of_origin: 'China'
              })
Miner.create!({
                name: 'ASICMiner Block Erupter Blade',
                currency: 'BTC',
                price: 50.0,
                ghps: 13,
                power_use_watt: 75,
                availability: 'No',
                country_of_origin: 'China'
              })


Miner.create!({
                name: 'Avalon Batch 3',
                currency: 'BTC',
                price: 75.0,
                ghps: 65,
                power_use_watt: 620,
                availability: 'No',
                country_of_origin: 'China'
              })

Miner.create!({
                name: 'Big Picture Mining K1 Nano',
                currency: 'BTC',
                price: 0.5,
                ghps: 0.3,
                power_use_watt: 2,
                availability: '2 Months',
                country_of_origin: 'US'
              })

Miner.create!({
                name: 'Butterfly Labs 5 GH/s SC',
                currency: 'USD',
                price: 274,
                ghps: 5,
                power_use_watt: 30,
                availability: '2 Months',
                country_of_origin: 'US'
              })

Miner.create!({
                name: 'Butterfly Labs 7 GH/s SC (upgraded 5)',
                currency: 'USD',
                price: 374,
                ghps: 7,
                power_use_watt: 40,
                availability: '2 Months',
                country_of_origin: 'US'
              })

Miner.create!({
                name: 'Butterfly Labs 25 GH/s SC',
                currency: 'USD',
                price: 1249,
                ghps: 25,
                power_use_watt: 150,
                availability: '2 Months',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'Butterfly Labs 30 GH/s SC (upgraded 25)',
                currency: 'USD',
                price: 1399,
                ghps: 30,
                power_use_watt: 180,
                availability: '2 Months',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'Butterfly Labs 50 GH/s Miner',
                currency: 'USD',
                price: 2499,
                ghps: 50,
                power_use_watt: 300,
                availability: '2 Months',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'Butterfly Labs 60 GH/s Miner (upgraded 50)',
                currency: 'USD',
                price: 2999,
                ghps: 60,
                power_use_watt: 360,
                availability: '2 Months',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'Butterfly Labs 500 GH/s Miner',
                currency: 'USD',
                price: 22484,
                ghps: 500,
                power_use_watt: 3000,
                availability: '2 Months',
                country_of_origin: 'US'
              })


Miner.create!({
                name: 'KnCMiner Mercury',
                currency: 'USD',
                price: 1995,
                ghps: 100,
                power_use_watt: 250,
                availability: '2 Months',
                country_of_origin: 'Sweden'
              })
Miner.create!({
                name: 'KnCMiner Saturn',
                currency: 'USD',
                price: 3795,
                ghps: 200,
                power_use_watt: 500,
                availability: '2 Months',
                country_of_origin: 'Sweden'
              })
Miner.create!({
                name: 'KnCMiner Jupiter',
                currency: 'USD',
                price: 6995,
                ghps: 400,
                power_use_watt: 100,
                availability: '2 Months',
                country_of_origin: 'Sweden'
              })


Miner.create!({
                name: 'Krater Miner',
                currency: 'USD',
                price: 90.0,
                ghps: 90,
                power_use_watt: 1000,
                availability: '2 Months',
                country_of_origin: 'US'
              })

Miner.create!({
                name: 'TerraHash Klondike 16',
                currency: 'USD',
                price: 250,
                ghps: 4.5,
                power_use_watt: 32,
                availability: 'No',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'TerraHash Klondike 64',
                currency: 'USD',
                price: 900,
                ghps: 18,
                power_use_watt: 128,
                availability: 'No',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'TerraHash DX Mini',
                currency: 'USD',
                price: 6000,
                ghps: 90,
                power_use_watt: 640,
                availability: 'No',
                country_of_origin: 'US'
              })
Miner.create!({
                name: 'TerraHash DX Large',
                currency: 'USD',
                price: 10500,
                ghps: 180,
                power_use_watt: 1280,
                availability: 'No',
                country_of_origin: 'US'
              })

Asset.create!({
                name: block_erupter.name,
                assetable: block_erupter,
                quantity: 10
              })
