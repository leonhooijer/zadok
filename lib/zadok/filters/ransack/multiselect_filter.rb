# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class MultiselectFilter < Base
        def describe(current_params)
          return [] if current_params[param].blank?
          options.map do |key, value|
            value if current_params[param].include?(key)
          end.compact.join(", ")
        end

        def type
          :multiselect
        end

        def active_in?(current_params)
          super && (current_params[param] & options.keys).present?
        end
      end
    end
  end
end
