local isInit = false

function ArenaSquelcher_FilterFunc(msg, ...)
    if msg == "Arena Broadcast Messages disabled." then
        if isInit then
            ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", ArenaSquelcher_FilterFunc)
        end
        return true
    elseif msg == "Arena Broadcast Messages enabled." then
        return true
    end

    return false
end

local ArenaSquelcher_EventFrame = CreateFrame("Frame")
ArenaSquelcher_EventFrame:RegisterEvent("PLAYER_LOGIN")
ArenaSquelcher_EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")

ArenaSquelcher_EventFrame:SetScript("OnEvent",
    function(self, event, ...)
        if isInit then
            return
        end

        if event == "PLAYER_LOGIN" then
            -- Gogogo, disable them messages
            SendChatMessage('.character arenaBroadcast')
        elseif event == "CHAT_MSG_SYSTEM" then
            local msg = ...
            if msg == "Arena Broadcast Messages disabled." then
                -- If we've gotten here, we've disabled the messages, and the addon is considered intialized
                isInit = true
            elseif msg == "Arena Broadcast Messages enabled." then
                -- If this is a reload, broadcast messages are preserved. This will redisable them
                SendChatMessage('.character arenaBroadcast')
            end
        end
    end
)

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ArenaSquelcher_FilterFunc)