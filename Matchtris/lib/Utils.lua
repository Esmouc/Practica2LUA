
function TableContains (t, n)
  for _,v in pairs(t) do
    if v == n then
      return true
    end
  end
  return false
end
