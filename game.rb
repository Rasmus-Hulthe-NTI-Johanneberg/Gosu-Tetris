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
        @block_cube = [[0, 0], [1, 0], [0, 1], [1, 1]]
        @blocks = []
        @current_moving = []
        @current_pos
        @block_x_offset = 300
        @block_y_offset = 100
        for i in 0..10 do
            @grid.append([@mid+@grid_dist_x*(i-5), @y_offset + @grid_dist_y*20, @mid+@grid_dist_x*(i-5), @y_offset])
        end
        for i in 0..20 do
            @blocks.append([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
            @grid.append([@mid-@grid_dist_x*5, @y_offset + i*@grid_dist_y, @mid+@grid_dist_x*5, @y_offset + i*@grid_dist_y])
        end
        spawn_piece()
    end

    def update
        
    end

    def draw_grid
        @grid.each{|line|
            self.draw_line(line[0], line[1],@fushia, line[2], line[3], @green)    
        }
        for block_y in 0...20 do
            for block_x in 0...10 do
                if @blocks[block_y][block_x] != nil
                    self.draw_rect(@block_x_offset + 40*block_x+1.5, @block_y_offset + 40*block_y+1.5, 37, 37, @blocks[block_y][block_x])
                    #puts block_y
                    #puts block_x
                    #puts ''
                end
            end
        end
    end

    def spawn_piece()
        @current_moving = @block_cube
        @current_pos = [4, 0]
    end

    def gravity()
        fall = true
        #p @blocks
        blocky_copy = []
        @blocks.each{|row| blocky_copy.append(row.clone)}
        #print blocky_copy
        @current_moving.each { |part|
            @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = nil
        }
        @current_moving.each { |part|
            if part[1] + @current_pos[1] + 1 <= 19
                if part[0] + @current_pos[0] <= 9
                    if @blocks[part[1] + @current_pos[1] + 1][part[0] + @current_pos[0]] != nil
                        fall = false
                    end
                else
                    fall = false

                end
            else
                fall = false
            end
        }
        if fall == true
            @current_pos[1] += 1
            @current_moving.each { |part|
                @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @yellow_block
            }
        else
            @blocks = blocky_copy
            print blocky_copy
            spawn_piece()
        end
    end
    def draw
        draw_grid()
        gravity()
        #self.draw_line(100,0,@fushia, 500, 1000, @green)
        #p @frame
        #@image.draw(@krister_coords[0], @krister_coords[1], 0, @krister_size_percent[0], @krister_size_percent[1])
    end
end

Intro.new.show