module Prawn
  module Graph
    module ChartComponents

      class GridRenderer
        attr_reader :grid_series, :grid_canvas, :grid_prawn

        def initialize(series, canvas)
          @grid_series = series
          @grid_canvas = canvas
          @grid_prawn = canvas.prawn

          @grid_graph_area = @grid_canvas.layout.graph_area

          @grid_plot_area_width = @grid_graph_area.width - 25
          @grid_plot_area_height = @grid_graph_area.height - 20
        end

        def show_grid
          small_grids
          large_grids
        end

        def small_grids
          graph_start_coordinate = grid_canvas.options[:at]
          i = 0
          j = 0

          # calculations for vertical grid line
          frequency = 300
          series_length = @grid_series.first.values.length
          total_time_in_seconds = (series_length.to_f / frequency)
          square_width = total_time_in_seconds / 0.04

          # calculations for horizontal grid line
          y_axis_line = graph_start_coordinate[1] - 26 - @grid_plot_area_height
          horizontal_grid_height = @grid_plot_area_height * 0.1

          # grid line theme parameters
          grid_prawn.stroke_color = 'E1E1E1'
          grid_prawn.line_width = 0.05
          grid_prawn.dash(500)

          # vertical grid lines for the scale of 0.04s x 0.1 mV
          while i <= @grid_plot_area_width
            grid_prawn.stroke_vertical_line(graph_start_coordinate[1] - 26, graph_start_coordinate[1] - 26 - (@grid_plot_area_height * 2), at: i + graph_start_coordinate[0] + 27)
            i = i + (@grid_plot_area_width/square_width)
          end

          # horizontal grid lines for the scale of 0.04s x 0.1 mV
          while horizontal_grid_height * j <= @grid_plot_area_height
            # above x-axis line
            grid_prawn.stroke_horizontal_line(graph_start_coordinate[0] + 27, graph_start_coordinate[0] + 27 + @grid_plot_area_width, at: y_axis_line + (horizontal_grid_height * j))
            # below x-axis line
            grid_prawn.stroke_horizontal_line(graph_start_coordinate[0] + 27, graph_start_coordinate[0] + 27 + @grid_plot_area_width, at: y_axis_line - (horizontal_grid_height * j))
            j = j + 1
          end
        end

        def large_grids
          graph_start_coordinate = grid_canvas.options[:at]
          i = 0
          j = 0

          # calculations for vertical grid line
          frequency = 300
          series_length = @grid_series.first.values.length
          total_time_in_seconds = (series_length.to_f / frequency)
          square_width = total_time_in_seconds / 0.2

          # calculations for horizontal grid line
          y_axis_line = graph_start_coordinate[1] - 26 - @grid_plot_area_height
          horizontal_grid_height = @grid_plot_area_height * 0.5

          # grid line theme parameters
          grid_prawn.stroke_color = 'FDA8A8'
          grid_prawn.line_width = 0.05
          grid_prawn.dash(500)

          # vertical grid lines for the scale of 0.2s x 0.5 mV
          while i <= @grid_plot_area_width
            grid_prawn.stroke_vertical_line(graph_start_coordinate[1] - 26, graph_start_coordinate[1] - 26 - (@grid_plot_area_height * 2), at: i + graph_start_coordinate[0] + 27)
            i = i + (@grid_plot_area_width/square_width)
          end

          # horizontal grid lines for the scale of 0.2s x 0.5 mV
          while horizontal_grid_height * j <= @grid_plot_area_height
            # above x-axis line
            grid_prawn.stroke_horizontal_line(graph_start_coordinate[0] + 27, graph_start_coordinate[0] + 27 + @grid_plot_area_width, at: y_axis_line + (horizontal_grid_height * j))
            # below x-axis line
            grid_prawn.stroke_horizontal_line(graph_start_coordinate[0] + 27, graph_start_coordinate[0] + 27 + @grid_plot_area_width, at: y_axis_line - (horizontal_grid_height * j))
            j = j + 1
          end
        end

      end
    end
  end
end
