# frozen_string_literal: true

require "abbrev"

module Zadok
  module Filters
    module Ransack
      class NumericRangeFilter < Base
        def describe(current_params = {})
          left, right = range_ends current_params
          key = key_from_range_ends left, right
          if key
            I18n.t("filter_labels.numeric_range.#{key}", left: left, right: right)
          else
            left
          end
        end

        def range_ends(current_params = {})
          params.map do |param|
            x = current_params[param]
            x == "" ? nil : x
          end
        end

        def key_from_range_ends(left, right)
          if left && right
            "closed" if left != right
          elsif right
            "left_open"
          elsif left
            "right_open"
          else
            raise "Both range ends missing; filter shouldn't be active"
          end
        end

        def type
          :numeric_range_field
        end

        def active_in?(current_params = {})
          range_ends(current_params).any?
        end

        def name
          prefix = common_prefix params.map(&:to_s)
          prefix = params.join("_") + "_" if prefix.empty?
          prefix + "range"
        end

        def common_prefix(strings)
          strings.abbrev.keys.sort_by(&:length).first[0..-2]
        end

        def value(current_params)
          left, right = range_ends current_params
          if left == right
            left
          elsif left || right
            "#{left} - #{right}"
          else
            ""
          end
        end

        def popover_content
          I18n.t("filter_labels.numeric_range.popover_text")
        end
      end
    end
  end
end
