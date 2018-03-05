# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class OptionsFilter < Base
        def current_params
          options[current_params[param]]
        end

        def type
          :options
        end
      end
    end
  end
end
