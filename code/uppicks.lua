--LUA

function spawnpickup()
  -- get the current selected one
  local g_pku = pickups:get(pickup_select)
  -- add to the select
  pickup_select = pickup_select + 1
  -- if it reachead max then go back to one
  if pickup_select > pickup_max then
    pickup_select = 1
  end

  -- set pos
  g_pku.x = math.random(0,love.graphics.getWidth()) -- the x doesnt matter because its really about how far
  g_pku.y = 0 -- y math for spawning

end

function updatepickups(dt)
  -- load all pickups
  for i=1,pickups.length do
    -- localize the pickup
    local g_pku = pickups:get(i)
    -- do movement multiplied by speed
    g_pku.y = g_pku.y + ( (dt * 25) * pickup_speed )
    g_pku.velocity.x = 0
    g_pku.velocity.y = 0
    -- save player distance
    local plyr_dist = distance(player.x,player.y,g_pku.x,g_pku.y)
    -- if within the pickup radius
    if plyr_dist < pickup_collect_radius then
        g_pku.velocity.x = ( (player.x + player.width/2) -   (g_pku.x  + g_pku.width/4 * 3 ) )  * pickup_collect_mult
        g_pku.velocity.y = ( (player.y - player.height/2)  - (g_pku.y  + g_pku.height/2 ) ) * pickup_collect_mult

        -- do actual pickup
        if plyr_dist < pickup_clct_fnl then
          -- do pickup shit here

          dopowerup(g_pku.type,g_pku.duration)

          g_pku.x = math.random(0,love.graphics.getWidth()) -- the x doesnt matter because its really about how far
          g_pku.y = -(pickup_st_o + ((math.random(pickup_iv_min,pickup_iv_max)) * math.random(1,pickup_dsfs))) -- y math for spawning

        end
        -- end of if
    end
    -- if player misses the pickup
    if g_pku.y > love.graphics.getHeight() then
      -- set pos
      g_pku.x = math.random(0,love.graphics.getWidth()) -- the x doesnt matter because its really about how far
      g_pku.y = -(pickup_st_o + ((math.random(pickup_iv_min,pickup_iv_max)) * math.random(1,pickup_dsfs))) -- y math for spawning
    end
    -- end of for
  end
  -- end of function
end

-- include the distance formual
function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end
