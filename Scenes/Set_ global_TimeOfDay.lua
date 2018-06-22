--[[ 
%% autostart 
%% properties
%% globals
--]]

-- In Variabels panel create a global variable.
-- Variable name : TimeOfDay
-- Leave the value as default "0", this script will change it based on time of day


local debug = true;

local function log(str) if debug then fibaro:debug(str); end; end

local sourceTrigger = fibaro:getSourceTrigger();
if (sourceTrigger["type"] == "autostart") then
  
  -- check script instance count in memory 
  if (tonumber(fibaro:countScenes()) > 1) then 
    log("Script already running.");
    fibaro:abort(); 
  end

  log("HC2 start script at " .. os.date());

  while true do 
    local night = "00:00";
    local morning = "06:00";
    local afternoon = "12:00";
    local evening = "18:00";
    local currentTime = os.date("%H:%M");
    local TimeOfDay = fibaro:getGlobal("TimeOfDay");

    if ( night <= currentTime and currentTime < morning and TimeOfDay ~= "night" ) 
    then 
      fibaro:setGlobal("TimeOfDay", "night");
      log("night");
    elseif ( morning <= currentTime and currentTime < afternoon and TimeOfDay ~= "morning" ) 
    then 
      fibaro:setGlobal("TimeOfDay", "morning");
      log("morning");
    elseif ( afternoon <= currentTime and currentTime < evening and TimeOfDay ~= "afternoon" ) 
    then
      fibaro:setGlobal("TimeOfDay", "afternoon");
      log("afternoon");
    elseif ( evening <= currentTime and currentTime <= "23:59" and TimeOfDay ~= "evening" ) 
    then
      fibaro:setGlobal("TimeOfDay", "evening");
      log("evening");
    end
    fibaro:sleep(60*1000);
  end
else
  log("Script can only be run via autostart");
end
