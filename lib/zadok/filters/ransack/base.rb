# frozen_string_literal: true

module Zadok
  module Filters
    module Ransack
      class Base
        def initialize(opts = {})
          @params = opts[:params]
        end

        attr_reader :params

        # most filters just use a single param
        def param
          params[0]
        end

        def active_in?(current_params)
          params.any? { |param| current_params.include? param }
        end

        def index
          99
        end

        def i18n_name
          I18n.t("filter.#{self.class.name.split('::').last.underscore}")
        end

        def title
          i18n_name
        end

        def describe(_current_params)
          raise NotImplementedError
        end

        # form control type
        def type
          raise NotImplementedError
        end

        def text(_current_params)
          param
        end

        # options hash for filters with options
        def options
          I18n.t("filter_labels.#{param}").with_indifferent_access
        end

        # Each filter may opt to change the column(s) of the filtered admission
        # list table - add or remove some.
        def modify_columns(columns)
          columns
        end

        def remove_from_params(current_params)
          current_params.except(*params)
        end

        def add_to_params(current_params, value)
          current_params.merge(param => value)
        end
      end
    end
  end
end
