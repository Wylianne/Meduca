describe("Teste do Jogo Bonus do Meduca e colisão", function()
  
      
    it("testando a colisão entre dois objetos", function()
      local colisao = require("colisao")
      
      local obj1 = {x = 180, y = 100, contentWidth = 360}
      local obj2 = {x = 180, y = 100, contentWidth = 360}
      
      assert.True( colisao:hasCollidedCircle( obj1, obj2 )
        
        )
    end)
  
    it("testando a falta de colisão entre dois objetos", function()
      local colisao = require("colisao")
      
      local obj1 = {x = 180, y = 100, contentWidth = 360}
      local obj2 = {x = 180, y = 500, contentWidth = 360}
      
      assert.falsy( 
        
        colisao:hasCollidedCircle( obj1, obj2 )
        
        )
      --assert.is_true(1 == 1)

      --assert.falsy(nil)
      --assert.truthy("Yup.")
    end)

end)