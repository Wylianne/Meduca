describe("Meduca tests.", function()
    
  describe("Quebra Ossos test.", function()
    it(" Score equal sixteen", function()
      local calcUtils = require("calcUtils")
      
      
      assert.are.equals("0",calcUtils.score("16"))

end)

 it(" Score greater zero", function()
        
      local calcUtils = require("calcUtils")
      
      
      assert.are.equals("8",calcUtils.score("20"))


end)

  end)
end)