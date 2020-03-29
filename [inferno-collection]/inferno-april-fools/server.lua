-- Inferno Collection April Fools Version 1.0 Alpha
--
-- Copyright (c) 2019, Christopher M, Inferno Collection. All rights reserved.
-- Copyright (c) 2020, Daniel A. Hawton, Inferno Collection
--
-- This project is licensed under the following:
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to use, copy, modify, and merge the software, under the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THE SOFTWARE MAY NOT BE SOLD.
--

--
--		Nothing past this point needs to be edited, all the settings for the resource are found in the config.lua file.
--		Do not make changes below this line unless you know what you are doing!
--

local players = {}

if Config.onConnect then
    AddEventHandler("playerConnecting", function(_, _, deferrals)
        local t = os.date("*t")
        if t.month == Config.onConnectDate.month and t.day == Config.onConnectDate.day then
            deferrals.defer()
            if not players[source] then
                players[source] = true   -- They can reconnect
                CancelEvent()
                deferrals.done("You have been permanently banned from this server. You can view the reason and appeal this ban at " .. Config.url)
            end
        end
    end)
end

if Config.registerCommand then
    RegisterCommand(Config.commandName, function(source)
        if source == 0 then
            for i=1,GetNumPlayerIndices(),1 do
                if NetworkIsPlayerActive(GetPlayerFromServerId(i)) then
                    DropPlayer(src, '\n\nYou have been permanently banned from this server, reason:\n\nView reason and appeal at: ' .. Config.url)
                end
            end
        end
    end)
end
