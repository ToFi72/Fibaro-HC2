--[[
%% properties
%% autostart
%% globals
--]]


local pir1      = 105;  -- * change this to the id of your pir/motion detector *
local pir2      = 105;

local light     = 33;  -- * change this to the id of your light (dimmer only) *

local duration  = 600; -- seconds to keep on the light after last detected movement

local countdown = 0;
local movement1;
local movement2;
local tod = fibaro:getGlobalValue("TimeOfDay")
local DimLvl;

if tod == "morning" then
  DimLvl = 70; -- in % Dim level
elseif tod  == "afternoon" then
  DimLvl = 100; -- in % Dim level
elseif tod  == "evening" then 
  DimLvl = 70; -- in % Dim level
elseif tod == "night" then 
  DimLvl = 50; -- in % Dim level
else
  DimLvl = 100; -- in % Dim level If no Global is present.
end

-- fibaro:debug("Time of Day : "..tod)
-- fibaro:debug("Dim Level : "..DimLvl)

while true do
  local movement1 = tonumber(fibaro:getValue(pir1, 'value'))  ;
  local movement2 = tonumber(fibaro:getValue(pir2, 'value'))  
  if ( movement1 == 1 ) or ( movement2 == 1 ) then
    countdown = duration;
  end
  
  if ( countdown > 0 ) then
    if ( tonumber(fibaro:getValue(light, 'value')) == 0 ) then
--      fibaro:call(light, "turnOn");
      fibaro:call(light, "setValue", DimLvl)
    end
    
    countdown = countdown - 1;
  end
  
  if ( countdown == 0 and tonumber(fibaro:getValue(light, 'value')) > 0 ) then
    fibaro:call(light, "turnOff");
  end
  
  fibaro:sleep(1000);
end
