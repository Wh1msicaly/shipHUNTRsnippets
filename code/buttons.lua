function newbutton(x,y,text,buttonset)
  -- default text
  if text == nil then text = "EMPTY" end

  -- create button object
  local button = {
    -- the x
    x = x,
    -- the y
    y = y,
    -- open
    open = true,
    -- create display sprite
    sprite = createsprite(nil,x,y,image),
    -- create button text
    text = createsprite(nil,x,y,"textf"),
    -- bool if pressed
    pressed = false,
    -- states image
    stateimg = buttonset
  }

  -- manage button after creating
  -- set first state
  button.sprite.image = button.stateimg[1]
  -- auto size for limit
  autosizesprite(button.sprite)
  -- set  fonts
  button.text.font = ss_font
  -- set  limit
  button.text.limit = button.sprite.width
  -- set  text
  button.text.text = text

  -- set to middle
  button.sprite.x = button.sprite.x - button.sprite.width/2
  button.text.x = button.text.x - button.sprite.width/2

  button.x = button.text.x

  -- set visibility  for both sprites
  button.setvisiblity = function(self,bool)
    self.sprite.visible = bool
    self.text.visible = bool
  end

  -- run
  button.update = function(self,x,y,pressed)
    -- unpress
    self.pressed = false
    -- now check for open
    if self.open then
      -- check pressed
      if pressed then
        -- check for touch
        if istouchpoint(self.sprite,x,y) then
        -- set press state
        self.pressed = true
        -- set open
        self.open = false
        end
        --  end istouchpoint
      end
      -- end pressed
    end
    -- end self.open
    -- set images based on press
    if self.pressed then
      self.sprite.image  = self.stateimg[2]
      self.text.y  = self.y + pxllockvalue(1)
    else
      self.sprite.image = self.stateimg[1]
      self.text.y  = self.y
    end

  end
  -- button close for reseting after running update multiple times
  button.close = function(self)
    -- reopen
    self.open = true
  end

  return button

end
