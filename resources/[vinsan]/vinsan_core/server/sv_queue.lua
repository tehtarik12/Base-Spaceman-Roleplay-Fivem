Queue = {}
Queue.Ready = false
Queue.Exports = nil
Queue.ReadyCbs = {}
Queue.CurResource = GetCurrentResourceName()

if Queue.CurResource == "vinsan_core" then return end

function Queue.OnReady(cb)
    if not cb then return end
    if Queue.IsReady() then cb() return end
    table.insert(Queue.ReadyCbs, cb)
end

function Queue.OnJoin(cb)
    if not cb then return end
    Queue.Exports:OnJoin(cb, Queue.CurResource)
end

function Queue.AddPriority(id, power, temp)
    if not Queue.IsReady() then return end
    Queue.Exports:AddPriority(id, power, temp)
end

function Queue.RemovePriority(id)
    if not Queue.IsReady() then return end
    Queue.Exports:RemovePriority(id)
end

function Queue.IsReady()
    return Queue.Ready
end

function Queue.LoadExports()
    Queue.Exports = exports.vinsan_core:GetQueueExports()
    Queue.Ready = true
    Queue.ReadyCallbacks()
end

function Queue.ReadyCallbacks()
    if not Queue.IsReady() then return end
    for _, cb in ipairs(Queue.ReadyCbs) do
        cb()
    end
end

AddEventHandler("onResourceStart", function(resource)
    if resource == "vinsan_core" then
        while GetResourceState(resource) ~= "started" do Citizen.Wait(0) end
        Citizen.Wait(1)
        Queue.LoadExports()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == "vinsan_core" then
        Queue.Ready = false
        Queue.Exports = nil
    end
end)

SetTimeout(1, function() Queue.LoadExports() end)

RegisterCommand('addpriority', function(source, args, rawcommand)
    local temp = args[2] and tonumber(args[2]) or nil
    local identifier = args[1] and args[1] or nil

    if identifier then
        Queue.AddPriority(identifier, temp)
    end
    print(args[2], args[1], temp, identifier)
end, true)

RegisterCommand('removepriority', function(source, args, rawcommand)
    local identifier = args[1] and args[1] or nil

    if identifier then
        Queue.RemovePriority(identifier)
    end
    print(args[1], identifier)
end, true)

RegisterCommand('setpriority', function(source, args, rawcommand)
    local identifier = args[1] and args[1] or nil
    local priority = args[2] and tonumber(args[2]) or nil

    if identifier then
        Queue.Exports:SetPos(identifier, priority)
    end
    print(args[1], args[2], identifier, priority)
end, true)