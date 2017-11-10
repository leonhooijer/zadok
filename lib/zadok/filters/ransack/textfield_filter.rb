# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class TextfieldFilter < Base
        def describe(current_params)
          current_params[param]
        end

        def type
          :textfield
        end
      end
    end
  end
end