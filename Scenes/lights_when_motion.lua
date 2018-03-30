--[[
%% properties
%% autostart
%% globals
--]]


local pir1      = 96;  -- * change this to the id of your pir/motion detector *
local pir2      = 138;

local light     = 104;  -- * change this to the id of your light (dimmer only) *

local duration  = 1800; -- seconds to keep on the light after last detected movement
-- sets local variables
local countdown = 0;
local movement1;
local movement2;
-- resets countdown on movement
while true do
  local movement1 = tonumber(fibaro:getValue(pir1, 'value'))  ;
  local movement2 = tonumber(fibaro:getValue(pir2, 'value'))  
  if ( movement1 == 1 ) or ( movement2 == 1 ) then
    countdown = duration;
  end
-- turns on lights when countdown resets 
  if ( countdown > 0 ) then
    if ( tonumber(fibaro:getValue(light, 'value')) == 0 ) then
      fibaro:call(light, "turnOn");
    end
-- countdown loop    
    countdown = countdown - 1;
  end
-- turns off lights when countdown reach zero  
  if ( countdown == 0 and tonumber(fibaro:getValue(light, 'value')) > 0 ) then
    fibaro:call(light, "turnOff");
  end
  
  fibaro:sleep(1000);
end
