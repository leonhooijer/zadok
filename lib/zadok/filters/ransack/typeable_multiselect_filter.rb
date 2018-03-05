# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class TypeableMultiselect < Base
        def describe(current_params)
          options.map do |key, value|
            value if current_params[param].include?(key)
          end.compact.join("|")
        end

        def type
          :typeable_multiselect
        end
      end
    end
  end
end
