module Prawn
  module Graph
    module ChartComponents
      # The Prawn::Graph::ChartComponents::BarChartRenderer is used to plot one or more bar charts 
      # in a sensible way on a a Prawn::Graph::ChartComponents::Canvas and its associated 
      # Prawn::Document.
      #
      class BarChartRenderer < SeriesRenderer
        def render
          render_the_chart
        end

        private

        def render_the_chart
          prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
         
            prawn.save_graphics_state do  
              num_points        = @series[0].size
              width_per_point   = (@plot_area_width / num_points)
              width             = (((width_per_point * 0.9) / @series.size).round(2)).to_f
              min_marked        = false
              max_marked        = false

              num_points.times do |point|

                @series.size.times do |series_index|
                  series_offset = series_index + 1
                  prawn.fill_color    = @colors[series_index]
                  prawn.stroke_color  = @colors[series_index]
                  prawn.line_width  = width

                  starting = (prawn.bounds.left + (point * width_per_point))

                  x_position = ( (starting + (series_offset * width) ).to_f - (width / 2.0))
                  y_position = ((point_height_percentage(@series[series_index].values[point]) * @plot_area_height) - 5).to_f

                  prawn.fill_and_stroke_line([ x_position ,0], [x_position ,y_position]) unless @series[series_index].values[point].zero?

                  if @series[series_index].mark_average?
                    average_y_coordinate = (point_height_percentage(@series[series_index].avg) * @plot_area_height) - 5
                    prawn.line_width = 1
                    prawn.stroke_color = @colors[series_index]
                    prawn.dash(2)
                    prawn.stroke_line([0, average_y_coordinate], [ @plot_area_width, average_y_coordinate ])
                    prawn.undash
                  end

                  if @series[series_index].mark_minimum? && min_marked == false && !@series[series_index].values[point].zero? && @series[series_index].values[point] == @series[series_index].min
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.min
                      prawn.stroke_color = @canvas.theme.min
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([x_position, 0], [x_position, y_position])
                      prawn.undash

                      prawn.fill_ellipse([x_position, y_position ], 2)
                      min_marked = true
                    end
                  end

                  if @series[series_index].mark_maximum? && max_marked == false && @series[series_index].values[point] == @series[series_index].max
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.max
                      prawn.stroke_color = @canvas.theme.max
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([x_position, 0], [x_position, y_position])
                      prawn.undash

                      prawn.fill_ellipse([x_position, y_position ], 2)
                      max_marked = true
                    end
                  end
                end

              end

            end
            render_axes
          end
        end

      end
    end
  end
end