describe("Meduca tests.", function()
    
  describe("Cruzadas test.", function()
    it(" jogoP param can't be nil", function()
        
      assert.has_error(function()
                          local cruzadas = require("cruzadas")
                          jogo = nil
                          cruzadas:create(itens)
                       end, "jogoP can't be nil.")

  end)

  it(" jogoP param can't be empty", function()
        
      assert.has_error(function()
                          local cruzadas = require("cruzadas")
                          jogo = {}
                          cruzadas:create(jogo)
                       end, "jogoP can't be  empty.")

  end)

  it(" grid jogo param can't be nil.", function()
        
      assert.has_error(function()
                          local cruzadas = require("cruzadas")
                          local grid = nil
  
                           local tips = {
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                          }
                          
                          local jogo = {palavras = grid, dicas = tips}
                          cruzadas:create(jogo)
                       end, "grid jogo is nil")

end)


    it(" grid jogo param must be 8x8.", function()
        
      assert.has_error(function()
                          local cruzadas = require("cruzadas")
                          local grid = {
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                          }
  
                           local tips = {
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                                      {" "," "," "," "," "," "," "," "},
                          }
                          
                          local jogo = {palavras = grid, dicas = tips}
                          cruzadas:create(jogo)
                       end, "grid jogo has a invalid size (must be 8x8)")

  end)


  end)
end)