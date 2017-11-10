# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class AutocompleteFilter < Base
        def describe(current_params)
          current_params[param]
        end

        def model
          raise NotImplementedError
        end

        def attr
          raise NotImplementedError
        end

        def autocomplete_attribute
          raise NotImplementedError
        end

        def source
          model.to_s.downcase.pluralize
        end

        def options
          Hash[model.uniq.pluck(attr, autocomplete_attribute)]
        end

        def type
          :autocomplete
        end

        def field_id
          "#{source.singularize}_#{autocomplete_attribute}"
        end

        def target_field_id
          "q_#{param}"
        end

        def field_value(params)
          model.find_by(attr => describe(params))&.send(autocomplete_attribute)
        end
      end
    end
  end
end
