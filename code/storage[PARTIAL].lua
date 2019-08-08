function file_readprop()
  -- first get contents of props
  fl_props:open("r")
  -- then read it
  cn_props = fl_props:read()
  -- save variable for snip point
  local sn = -1
  -- save variable
  local mm = {}
  -- open for writing
  for i=1,string.len(cn_props) do
    -- body...
    local key = cn_props:sub(i,i)

    if key == "-" then
      mm[#mm+1] = cn_props:sub(sn+1,i-1)
      sn = i
    end

  end
  fl_props:close()
  return mm
end
