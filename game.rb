require 'gosu'

class Intro < Gosu::Window
    def initialize
        @window_size = [1000, 1000]
        super @window_size[0], @window_size[1]
        self.caption = 'Spiders In Your Favorite Shoes? Just Leeave Them Be, Couse Theyre More Scared Of You.'
        @mid = @window_size[0] / 2
        @grid = []
        @grid_dist_x = 40
        @grid_dist_y = 40
        @y_offset = 100
        @aqua = Gosu::Color.argb(0xff_00ffff)
        @green = Gosu::Color.argb(0xff_00ff00)
        @fushia = Gosu::Color.argb(0xff_ff00ff)
        @yellow_block = Gosu::Color.argb(0xff_ffff00)
        @blocks = []
        @current_moving = []
        for i in 0..10 do
            @grid.append([@mid+@grid_dist_x*(i-5), @y_offset + @grid_dist_y*20, @mid+@grid_dist_x*(i-5), @y_offset])
            @blocks
        end
        for i in 0..20 do
            @blocks.append([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
            @grid.append([@mid-@grid_dist_x*5, @y_offset + i*@grid_dist_y, @mid+@grid_dist_x*5, @y_offset + i*@grid_dist_y])
        end
        #p @grid

        
    end

    def update
        
    end

    def draw_grid
        @grid.each{|line|
            self.draw_line(line[0], line[1],@fushia, line[2], line[3], @green)    
        }
        
    end

    def spawn_piece()

    end

    def draw
        draw_grid()
        #self.draw_line(100,0,@fushia, 500, 1000, @green)
        #p @frame
        #@image.draw(@krister_coords[0], @krister_coords[1], 0, @krister_size_percent[0], @krister_size_percent[1])
    end
end

Intro.new.show