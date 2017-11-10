# frozen_string_literal: true

require "active_support/inflector"

module Zadok
  class FilterCollection
    attr_reader :filters, :params

    def initialize(params, filters_namespace = Zadok::Filters)
      @params = params
      @filters = []
      filters_namespace.constants.each do |constant|
        unless constant.match?(/Ransack/)
          @filters << "#{filters_namespace}::#{constant}".constantize.new
        end
      end
      @filters.sort! { |a, b| a.index <=> b.index }
    end

    def current_filters
      @filters.select do |filter|
        filter.active_in? params
      end
    end

    def current_filter_params(params)
      current_filters.flat_map(&:params).uniq.map do |param|
        [param, params[param]]
      end
    end

    def active_filters?
      current_filters.count.positive?
    end

    def variable_results?
      current_filters.any?(&:variable_results?)
    end
  end
end
