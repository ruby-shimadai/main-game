require 'dxruby'

require_relative 'apple'
require_relative 'bomd'
require_relative 'item'
require_relative 'playerRuby'

Window.bgcolor = [255, 128, 255, 255]
ground_img = Image.new(640, 80, [255, 116, 80, 48])
ground_img.box_fill(0, 0, 640, 10, [255, 0, 128, 0])
font = Font.new(32)

apples = []
apple_n = 5
apple_n.times do
  apples << Apple.new()
end

bombs = []
bomb_n = 5
bomb_n.times do
  bombs << Bomb.new()
end

items = []
item_n = 5
item_n.times do
  items << Item.new()
end

timer = 0
startTime = nil

player = Player.new()

Window.loop do
  timer = timer + 1

  if(startTime)
   # 秒数カウント
    if((timer-startTime)/60 >=10)
      puts timer-startTime
      player.game_end = true
      startTime = nil
      player.active = false
      
    end
  end
  Window.draw(0, 400, ground_img)


  if player.active
    Window.draw_font(50, 50, "秒数：#{(timer-startTime)/60 }", font, {color: C_BLUE})
    Sprite.update(apples)
    Sprite.update(bombs)
    Sprite.update(items)
    player.update

    Sprite.check(player, apples)
    Sprite.clean(apples)
    (apple_n - apples.size).times do
      apples << Apple.new()
    end

    Sprite.check(bombs, player)
    Sprite.clean(bombs)
    (bomb_n - bombs.size).times do
      bombs << Bomb.new()
    end

    Sprite.check(items, player)
    Sprite.clean(items)
    (item_n - items.size).times do
      items << Item.new()
    end
  end

  Sprite.draw(apples)
  Sprite.draw(bombs)
  Sprite.draw(items)
  player.draw

  Window.draw_font(10, 10, "落ち物ゲーム　スコア：#{player.score}", font, {color: C_BLUE})

  if !player.active # 以下追加
    if player.game_end
      Window.draw_font(210, 190, "ゲームオーバー", font, {color: C_BLUE})
    end
    Window.draw_font(120, 282, "スペースキー：ゲームスタート", font, {color: C_BLUE})
    Window.draw_font(181, 314, "ESCキー：ゲーム終了", font, {color: C_BLUE})
    if Input.key_push?(K_SPACE)
      startTime = timer
      if player.game_end
        apples.map {|apple| apple.vanish}
        Sprite.clean(apples)
        bombs.map {|bomb| bomb.vanish}
        Sprite.clean(bombs)
        items.map{|item| item.vanish}
        Sprite.clean(items)
      end
      player.restart
    elsif Input.key_push?(K_ESCAPE)
      break
    end
  end
end