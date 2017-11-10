# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class RangeFilter < Base
        def describe(current_params)
          current_params[param]
        end

        def type
          :range
        end

        def ticks
          options.map { |k, _v| k.to_s.to_i }
        end

        def ticks_labels
          options.map { |_k, v| v }
        end

        def ticks_positions
          ticks.map.with_index do |_tick, index|
            (100 / (ticks.count.to_f - 1)) * index
          end
        end
      end
    end
  end
end
