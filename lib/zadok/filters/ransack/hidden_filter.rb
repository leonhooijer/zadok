# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class HiddenFilter < Base
        def describe(current_params)
          current_params[param]
        end

        def type
          :hidden
        end
      end
    end
  end
end
