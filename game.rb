require 'gosu'

class Intro < Gosu::Window
    def initialize
        @window_size = [1000, 800]
        super @window_size[0], @window_size[1]
        self.caption = 'Spiders In Your Favorite Shoes? Just Leeave Them Be, Couse Theyre More Scared Of You.'
        @mid = @window_size[0] / 2
        @frame = 0
        @image = Gosu::Image.new("krister.PNG")
        @krister_size = [940, 920]#[1360, 720] #
        @krister_size_percent = [0.5, 0.5]
        @krister_coords = [0, 0]
        @krister_speed = [5, 5]
        @dir = [true, true]
    end

    def update

        if @dir[0]
            if ((@window_size[0]-(@krister_size[0]*@krister_size_percent[0])) - @krister_coords[0]) > 0
                @krister_coords[0] += @krister_speed[0]
            else
                @dir[0] = false
            end
        else
            if @krister_coords[0] != 0
                @krister_coords[0] -= @krister_speed[0]
            else
                @dir[0] = true
            end
        end


        if @dir[1]
            if ((@window_size[1]-(@krister_size[1]*@krister_size_percent[1])) - @krister_coords[1]) > 0
                @krister_coords[1] += @krister_speed[1]
            else
                @dir[1] = false
            end
        else
            if @krister_coords[1] > 0
                @krister_coords[1] -= @krister_speed[1]
            else
                @dir[1] = true
            end
        end
    end

    def draw
        #p @frame
        @image.draw(@krister_coords[0], @krister_coords[1], 0, @krister_size_percent[0], @krister_size_percent[1])
    end
end

Intro.new.show