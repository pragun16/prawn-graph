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
          i = 0
          j = 0
          graph_start_coordinate = grid_canvas.options[:at]
          grid_prawn.line_width = 0.5
          grid_prawn.stroke_color = 'E1DBDB'
          grid_prawn.dash(500)

          # vertical grid lines
          while i <= @grid_plot_area_width
            grid_prawn.stroke_vertical_line(graph_start_coordinate[1] - 26, graph_start_coordinate[1] - 26 - (@grid_plot_area_height*2), at: i + graph_start_coordinate[0] + 21)
            i = i + 5
          end

          # horizontal grid lines
          while j <= @grid_plot_area_height * 2 # x2 because currently, height equals height of 1st quadrant only
            grid_prawn.stroke_horizontal_line(graph_start_coordinate[0] + 20, @grid_plot_area_width + 30, at: graph_start_coordinate[1] - 27 - j)
            j = j + 5
          end
        end

      end
    end
  end
end
