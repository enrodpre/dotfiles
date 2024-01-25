local F = {}

function F.tbl_equals(t1, t2)
  if #t1 ~= #t2 then return false end

  for k, _ in pairs(t1) do
    if t1[k] ~= t2[k] then return false end
  end

  return true
end

function F.assert_tbl_equals(t1, t2)
  require("luassert").True(F.tbl_equals(t1, t2))
end

return F
