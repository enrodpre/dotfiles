local init = require("utils")
local test_util = require("utils.test_util")
local test_harness = require("plenary.test_harness")
local assert = require("luassert")

describe("Tests of init module", function()
  it("notifier_table", function() end)

  it("tbl_flatten", function()
    local expected = { a = 1, b = 2, c = 3, d = 4, e = 5, f = 6 }
    local actual = init.tbl_flatten({
      a = 1,
      x = {
        b = 2, c = 3
      },
      y = {
        d = 4, e = 5
      },
      f = 6
    }, 1)

    test_util.assert_tbl_equals(expected, actual)
  end)

  it("iter_to_table_filtered", function()
    local function create_iter()
      local i = 0
      local n = 15
      return function()
        i = i + 1
        if i <= n then return i end
      end
    end

    local function filter(x)
      return x % 3 == 0
    end

    local expected = { 3, 6, 9, 12, 15 }
    local actual = init.iter_to_table_filtered(create_iter(), filter)

    test_util.assert_tbl_equals(expected, actual)
  end)

  it("get_module_info", function() end)

  it("load_module", function()
    local expected = {
      a = 1, b = 2, c = 4, d = 3, e = 12, z = 'a', x = 'b'
    }
    local current = init.load_function_module("utils.tests.data.package")
    test_util.assert_tbl_equals(expected, current)

    expected = {
      b = 3, c = 2, d = 'abs', e = 12, z = 'a', x = 'b'
    }

    assert.False(test_util.tbl_equals(expected, current))
  end)
  it("module_abspath", function()
    local expected = "/home/kike/.config/nvim/lua/utils/tests/data/package"
    local actual = init.module_abspath("utils.tests.data.package")

    assert.equals(expected, actual)
  end)
end)
