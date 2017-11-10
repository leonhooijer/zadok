# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class SelectFilter < Base
        def describe(current_params)
          current_params[param]
        end

        def type
          :select
        end

        def html_options
          { class: "form-control" }
        end
      end
    end
  end
end
