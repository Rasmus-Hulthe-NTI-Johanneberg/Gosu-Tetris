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
        @rotation_map = {0=>1, 1=>2, 2=>3, 3=>0}
        @aqua = Gosu::Color.argb(0xff_00ffff)
        @green = Gosu::Color.argb(0xff_00ff00)
        @fushia = Gosu::Color.argb(0xff_ff00ff)
        @random_color = Gosu::Color.argb(0xff_ffccff)
        @red = Gosu::Color.argb(0xff_ff0000)
        @cube_color = Gosu::Color.argb(0xff_f7e444) # yellow
        @long_color = Gosu::Color.argb(0xff_32b4e1) # light blue
        @hook_1_color = Gosu::Color.argb(0xff_245594) # Blue
        @hook_2_color = Gosu::Color.argb(0xff_ea731d) # Yellow
        @squiggle_1_color = Gosu::Color.argb(0xff_73bc18) # Green
        @squiggle_2_color = Gosu::Color.argb(0xff_f72034) # Red


        
        @block_cube = [[0, 0], [1, 0], [0, 1], [1, 1]]
        @block_cube_2 = [[0, 0], [1, 0], [0, 1], [1, 1]]
        @block_cube_3 = [[0, 0], [1, 0], [0, 1], [1, 1]]
        @block_cube_4 = [[0, 0], [1, 0], [0, 1], [1, 1]]
        @cube_rotates = [@block_cube, @block_cube_2, @block_cube_3, @block_cube_4]

        @block_long = [[0, 0], [1, 0], [2, 0], [3, 0]]
        @block_long_2 = [[0, 0], [0, 1], [0, 2], [0, 3]]
        @block_long_3 = [[0, 0], [-1, 0], [-2, 0], [-3, 0]]
        @block_long_4 = [[0, 0], [0, -1], [0, -2], [0, -3]]
        @long_rotates = [@block_long, @block_long_2, @block_long_3, @block_long_4]

        @block_squiggle_1 = [[1, 0], [2, 0], [0, 1], [1, 1]]
        @block_squiggle_1_2 = [[0, 0], [0, 1], [1, 1], [1, 2]]
        @block_squiggle_1_3 = [[1, 0], [2, 0], [0, 1], [1, 1]]
        @block_squiggle_1_4 = [[0, 0], [0, 1], [1, 1], [1, 2]]
        @squiggle_1_rotates = [@block_squiggle_1, @block_squiggle_1_2, @block_squiggle_1_3, @block_squiggle_1_4]

        @block_squiggle_2 = [[0, 0], [1, 0], [1, 1], [2, 1]]
        @block_squiggle_2_2 = [[1, 0], [1, 1], [0, 1], [0, 2]]
        @block_squiggle_2_3 = [[0, 0], [1, 0], [1, 1], [2, 1]]
        @block_squiggle_2_4 = [[1, 0], [1, 1], [0, 1], [0, 2]]
        @squiggle_2_rotates = [@block_squiggle_2, @block_squiggle_2_2, @block_squiggle_2_3, @block_squiggle_2_4]

        @block_hook_2_yellow = [[0, 1], [1, 1], [2, 1], [2, 0]]
        @block_hook_2_yellow_2 = [[0, 0], [0, 1], [0, 2], [1, 2]]
        @block_hook_2_yellow_3 = [[0, 0], [0, 1], [1, 0], [2, 0]]
        @block_hook_2_yellow_4 = [[0, 0], [1, 0], [1, 1], [1, 2]]
        @hook_2_rotates = [@block_hook_2_yellow, @block_hook_2_yellow_2, @block_hook_2_yellow_3, @block_hook_2_yellow_4]

        @block_hook_1_blue = [[0, 0], [1, 0], [0, 1], [0, 2]]
        @block_hook_1_blue_2 = [[0, 1], [1, 1], [2, 1], [2, 2]]
        @block_hook_1_blue_3 = [[1, 0], [1, 1], [1, 2], [0, 2]]
        @block_hook_1_blue_4 = [[0, 0], [0, 1], [1, 1], [2, 1]]
        @hook_1_rotates = [@block_hook_1_blue, @block_hook_1_blue_2, @block_hook_1_blue_3, @block_hook_1_blue_4]

        @types_of_blocks = [    @cube_rotates,      @long_rotates,  @squiggle_1_rotates,    @squiggle_2_rotates,    @hook_1_rotates,    @hook_2_rotates]
        @block_colors = [       @cube_color,        @long_color,    @squiggle_1_color,      @squiggle_2_color,      @hook_1_color,      @hook_2_color]
        @current_peice = -1
        @current_peice_rotation = 0
        @current_peice_color = nil
        @blocks = []
        @current_moving = []
        @current_pos
        @block_x_offset = 300
        @block_y_offset = 100
        @counter = 0
        for i in 0..10 do
            @grid.append([@mid+@grid_dist_x*(i-5), @y_offset + @grid_dist_y*20, @mid+@grid_dist_x*(i-5), @y_offset])
        end
        for i in 0..20 do
            @blocks.append([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
            @grid.append([@mid-@grid_dist_x*5, @y_offset + i*@grid_dist_y, @mid+@grid_dist_x*5, @y_offset + i*@grid_dist_y])
        end
        @blocks.pop
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
        
        @current_peice = rand(0...6)
        p @current_peice
        @current_peice_rotation = 0
        @current_moving = @types_of_blocks[@current_peice][@current_peice_rotation]
        p @current_moving
        @current_peice_color = @block_colors[@current_peice]
        @current_pos = [4, 0]
    end

    def tETRIS_CLEAR_LINE()
        @blocks.each_with_index{|line, index|
            #p line, index
            if not line.include?(nil)
                #p @blocks
                @blocks.delete_at(index)
                @blocks.insert(0, [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
            end
        }
    end

    def move_left()
        fall = true
        blocky_copy = []
        @blocks.each{|row| blocky_copy.append(row.clone)}
        @current_moving.each { |part|
            @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = nil
        }
        @current_moving.each { |part|
            if part[1] + @current_pos[1] <= 19
                if part[0] + @current_pos[0] - 1 >= 0
                    if @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]-1] != nil
                        fall = false
                    end
                else
                    fall = false
                    break

                end
            else
                fall = false
            end
        }
        if fall == true
            @current_pos[0] -= 1
            @current_moving.each { |part|
                @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @current_peice_color
            }
        else
            @blocks = blocky_copy
        end
    end
    def move_right()
        fall = true
        blocky_copy = []
        @blocks.each{|row| blocky_copy.append(row.clone)}
        @current_moving.each { |part|
            @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = nil
        }
        @current_moving.each { |part|
            if part[1] + @current_pos[1] <= 19
                if part[0] + @current_pos[0] + 1 <= 9
                    if @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]+1] != nil
                        fall = false
                    end
                else
                    fall = false
                    break

                end
            else
                fall = false
            end
        }
        if fall == true
            @current_pos[0] += 1
            @current_moving.each { |part|
                @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @current_peice_color
            }
        else
            @blocks = blocky_copy
        end
    end

    def rotate()
                # REMEMBER TO CHANGE TO ALL BLOCKS NOT JUST TESTING BLOCK

        clear_moving_before_moving()
        if collision(@types_of_blocks[@current_peice][@rotation_map[@current_peice_rotation]]) == true
            @current_peice_rotation = @rotation_map[@current_peice_rotation]    
        end
        @current_moving = @types_of_blocks[@current_peice][@current_peice_rotation]
        @current_moving.each { |part|
            @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @current_peice_color
        }
    end


    def collision(peice)
        no_collision = true
        peice.each{|square|
            puts square[0] + @current_pos[0]
            if square[1] + @current_pos[1] + 1 > 19 || square[1] + @current_pos[1] < 0 || square[0] + @current_pos[0] > 9 || square[0] + @current_pos[0] < 0
                # Outside grid
                no_collision = false
                break
            elsif @blocks[square[1] + @current_pos[1] + 1][square[0] + @current_pos[0]] != nil
                no_collision = false
                break
            end}
        no_collision
    end

    def clear_moving_before_moving()
        @current_moving.each { |part|
            @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = nil
        }
    end

	def button_up(key_id)
		if key_id == Gosu::KbLeft then
			move_left()
        elsif key_id == Gosu::KbRight then
            move_right()
        elsif key_id == Gosu::KB_SPACE then
            #self.close
            full_gravity()
        elsif key_id == Gosu::KbDown then
            gravity()
        elsif key_id == Gosu::KbUp then
            rotate()
            #self.close
		end
	end

    def full_gravity()
        fall = true
        while fall == true do
            blocky_copy = []
            @blocks.each{|row| blocky_copy.append(row.clone)}
            
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
                    @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @current_peice_color
                }
            else
                @blocks = blocky_copy
                #print blocky_copy
                spawn_piece()
                tETRIS_CLEAR_LINE()
            end
        end
    end

    def gravity()
        fall = true
        #p @blocks
        blocky_copy = []
        @blocks.each{|row| blocky_copy.append(row.clone)}
        #print blocky_copy
        #p @current_moving
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
                @blocks[part[1] + @current_pos[1]][part[0] + @current_pos[0]] = @current_peice_color
            }
        else
            @blocks = blocky_copy
            #print blocky_copy
            spawn_piece()
            tETRIS_CLEAR_LINE()
        end
    end
    def draw
        draw_grid()
        @counter += 1
        if @counter > 15
            #p @current_pos
            #puts
            #puts
            gravity()
            @counter = 0
        end
    end
end

Intro.new.show