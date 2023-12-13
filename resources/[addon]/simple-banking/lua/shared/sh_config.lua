SimpleBanking = SimpleBanking or {} 
SimpleBanking.Config = SimpleBanking.Config or {}


SimpleBanking.Config["Days_Transaction_History"] = 30 -- How many days should the transaction history go back in the bank?

SimpleBanking.Config["business_ranks"] = { -- what ranks can see the society accounts in the menu, and deposit/withdraw/transfer from them?
    ['boss'] = true,
}

SimpleBanking.Config["business_ranks_overrides"] = {
    ['police'] = {
        ['boss'] = true,
    },
    ['ambulance'] = {
        ['boss'] = true,
    },
    ['mechanic'] = {
        ['boss'] = true,
    },
    ['pedagang'] = {
        ['boss'] = true,
    },
}