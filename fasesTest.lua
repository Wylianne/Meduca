describe("Meduca tests.", function()
    
  describe("Fases test.", function()
    it(" Itens param can't be nil", function()
        
      assert.has_error(function()
                          local fases = require("fases")
                          itens = nil
                          fases:create("",itens)
                       end, "itens can't be nil.")

  end)

  it(" Itens param can't be empty", function()
        
      assert.has_error(function()
                          local fases = require("fases")
                          itens = {}
                          fases:create("",itens)
                       end, "itens can't be  empty.")

  end)

  it(" Status itens param can't be nil and have to be 1 or 0 value.", function()
        
      assert.has_error(function()
                          local fases = require("fases")
                          itens = {{status = 2, scene="some"}}
                          fases:create("",itens)
                       end, "some status item is nil or has a invalid value (1 or 0 permited)")

  end)


  end)
end)