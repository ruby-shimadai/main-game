class Player < Sprite
  attr_accessor :score, :active, :game_end

  def initialize()
    image = Image.load("images/noschar1.png")
    x = (640 - image.width) / 2
    y = 400 - image.height
    @sound = Sound.new("sounds/get.wav")
    @score = 0
    @active = false # 変更
    @game_end = false # 追加a
    super(x, y, image)
  end

  def update
    dx = Input.x
    if (dx == -1 && self.x > 0) || (dx == 1 && self.x < (640 - image.width)) 
      self.x += dx
    end
  end

  def shot
    @sound.play
    @score += 1
  end

  def hit
    @active = true
    @game_end = true # 追加
  end

  def restart # 追加
    self.x = (640 - image.width) / 2
    self.y = 400 - image.height
    @score = 0
    @active = true
    @game_end = false
  end
end