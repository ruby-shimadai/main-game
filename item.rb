class Item < Sprite
    def initialize()
      image = Image.load("images/item.png")
      x = rand(0..(640 - image.width))
      y = 0
      @speed = rand(1..5)
      super(x, y, image)
    end
  
    def update
      self.y += @speed
      if self.y > 400 - image.height
        self.vanish
      end
    end
  
    def hit # 追加
      self.vanish
    end

    def shot(playerRuby)
      
        dx = Input.mouse_x
        if (x<dx && playerRuby.x<600)
          playerRuby.x += 4
       
      
        elsif(dx<x && 70<playerRuby.x)
          playerRuby.x -= 4
        end
      
  
    end
   

  end

