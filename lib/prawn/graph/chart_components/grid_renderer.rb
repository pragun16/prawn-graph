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
          # vertical grid lines
          while i<36
            grid_prawn.line_width = 0.5
            grid_prawn.stroke_color = 'E1DBDB'
            grid_prawn.dash(500)
            grid_prawn.stroke_line([12 + 25 + i*10, 700 - 26], [12 + 25 + i*10, 700 - (@grid_plot_area_height * 2) - 20])
            grid_prawn.undash
            i = i + 1
          end
          # horizontal grid lines
          j = 0
          while j<13
            grid_prawn.line_width = 0.5
            grid_prawn.stroke_color = 'E1DBDB'
            grid_prawn.dash(500)
            grid_prawn.stroke_line([12 + 25, 700 - 26 - j*10], [12 + 25 + @grid_plot_area_width, 700 - 26 - j*10])
            grid_prawn.undash
            j = j + 1
          end
          ap grid_canvas.options[:at]
        end

      end
    end
  end
end
