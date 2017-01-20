module Prawn
  module Graph
    class Theme

      attr_reader :theme

      # The default theme is special, only create one of them.
      #
      def self.default
        @@_default_theme ||= Prawn::Graph::Theme.new(Prawn::Graph::Theme::Default)
      end

      def initialize(arg)
        @series_map = {}
        @current_series_color = 0
        @theme = OpenStruct.new(Prawn::Graph::Theme::Default.merge(arg))
      end

      def number_of_colors
        theme.series.size
      end

      def ==(other)
        theme == other.theme
      end

      def color_for(series)
        @series_map[series.uuid] = cycle_color unless @series_map.has_key?(series.uuid)
        @series_map[series.uuid]
      end

      def font_sizes
        @font_sizes ||= OpenStruct.new({default:      8, main_title:   10, axis_labels:  5, series_key:   8 })
      end

      def method_missing(method_name, *arguments)
        if arguments.any?
          @theme.send(method_name, arguments)
        else
          @theme.send(method_name)
        end
      end

      Default = {series:'000000', title:'17202A', background:'FFFFFF', grid:'F2F4F4', axes:'000000', markers:'000000', stroke_grid_lines:true, default:'333333', average:'34495E', max:'17202A', min:'17202A' }

      private

      def cycle_color
        @theme.series
      end

    end
  end
end