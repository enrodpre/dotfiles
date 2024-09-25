#!/usr/bin/lua

local metatables = require("library.metatables")


describe("Testing metatables", function()
   describe("Testing mapper", function()
      it("should sum up one to every value", function()
         local mapping = function(key, value)
            return key, value + 1
         end
         local m = metatables.mapper(mapping)

         assert(type(m) == "table")

         m [1] = 1
         m [2] = 9
         m [3] = 4

         assert(m [1] == 2)
         assert(m [2] == 10)
         assert(m [3] == 5)
      end)
      it("should reapply fn when reset", function()
         local mapping = function(key, value)
            return key, value .. ", wassup"
         end
         local m = metatables.mapper(mapping)

         m [1] = "hi"
         assert(m [1] == "hi, wassup")
         m [1] = "bye"
         assert(m [1] == "bye, wassup")
      end)
      it("should apply mapping it data it filtered", function()
         local mapping = function(key, value)
            if value == "no" then
               value = "si"
            end
            return key, value
         end
         local m = metatables.mapper(mapping)

         m [1] = "quizas"
         m [2] = "no"
         m [3] = "si"
         m [4] = "no"
         m [5] = "quizas"

         assert(m [1], "quizas")
         assert(m [2], "si")
         assert(m [3], "si")
         assert(m [4], "si")
         assert(m [5], "quizas")
      end)
   end)
end)
