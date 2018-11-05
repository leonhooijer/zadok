# frozen_string_literal: true

class ZadokController < ApplicationController
  helper_method :edit_attributes
  helper_method :index_attributes
  helper_method :new_attributes
  helper_method :page_title
  helper_method :resource
  helper_method :resource_class
  helper_method :resource_name
  helper_method :resources
  helper_method :show_attributes
  helper_method :template_exists?

  def index
    respond_to do |format|
      format.csv { send_data(generate_csv) }
      format.html do
        filter_and_paginate_resources!
        render resource_template(:index)
      end
      format.json { render json: resources, root: false }
      format.xml { render xml: resources.map(&:attributes), root: controller_name }
    end
  end

  def show
    respond_to do |format|
      format.html { render resource_template(:show) }
      format.json { render json: resource, root: false }
      format.xml { render xml: resource.attributes, root: controller_name.singularize }
    end
  end

  def new
    render resource_template(:new)
  end

  def create
    if resource.save
      flash.success(t("zadok.create.success", model: resource_name))
      redirect_to url_for(controller: controller_name, action: :index)
    else
      resource.errors.full_messages.each { |message| flash.danger(message) }
      render resource_template(:new)
    end
  end

  def edit
    render resource_template(:edit)
  end

  def update
    if resource.update(resource_params)
      flash.success(t("zadok.update.success", model: resource_name))
    else
      resource.errors.full_messages.each { |message| flash.danger(message) }
    end
    render resource_template(:edit)
  end

  def destroy
    if resource.destroy
      flash.success(t("zadok.destroy.success", model: resource_name))
    else
      fresource.errors.full_messages.each { |message| flash.danger(message) }
    end
    redirect_to url_for(controller: controller_name, action: :index)
  end

  protected

  def filter_collection
    Zadok::FilterCollection.new(search_params, filters_namespace)
  end

  def filters_namespace
    "zadok/filters/#{controller_name}".classify.constantize
  rescue NameError => _e
    Zadok::Filters::NullFilter
  end

  def filtered_resources
    current_search.result
  end

  def search_params
    permitted_params.fetch(:q) { {} }
  end

  def current_search
    search_model.ransack(search_params)
  end

  def search_results
    current_search.result
  end

  def page
    permitted_params.fetch(:page, 1)
  end

  def per_page
    permitted_params.fetch(:per_page, 30)
  end

  def current_sort
    search_params.fetch(:s) { nil }
  end

  def permitted_params
    params.permit(:page, :per_page, q: %i[s search_model])
  end

  define_method("#{controller_name.singularize}_params") do
    params.require(controller_name.singularize).permit!
  end

  def resource_params
    send("#{controller_name.singularize}_params")
  end

  def resource
    instance_variable_get("@#{controller_name.singularize}")
  end

  def resources
    instance_variable_get("@#{controller_name}")
  end

  def resource_class
    controller_name.singularize.camelize.constantize
  end
  alias search_model resource_class

  def resource_name(variant = :one)
    if variant == :zero
      resource_class.model_name.human(count: 0)
    elsif variant == :one
      resource_class.model_name.human(count: 1)
    elsif variant == :other
      resource_class.model_name.human(count: 9)
    end
  end

  def resource_template(action)
    if template_exists?("#{controller_name}/#{action}")
      "#{controller_name}/#{action}"
    else
      "zadok/#{action}"
    end
  end

  def page_title
    t("zadok.#{action_name}.action", model: resource_name)
  end

  def filter_and_paginate_resources!
    instance_variable_set("@#{controller_name}", filtered_resources.paginate(page: page, per_page: per_page))
  end

  def show_attributes
    resource_class.attribute_names
  end

  def index_attributes
    resource_class.attribute_names
  end

  def new_attributes
    Hash[
      resource_class.attribute_types.map do |attr, type|
        next if attr.in?(%w[id created_at updated_at])

        [attr, { type: type.class.name.demodulize.underscore }]
      end.compact
    ]
  end

  def edit_attributes
    Hash[
      resource_class.attribute_types.map do |attr, type|
        next if attr.in?(%w[id created_at updated_at])

        [attr, { type: type.class.name.demodulize.underscore }]
      end.compact
    ]
  end

  def generate_csv
    CSV.generate(headers: true, col_sep: t("zadok.csv.col_sep")) do |csv|
      csv << resource_class.attribute_names

      filtered_resources.each do |resource|
        csv << resource_class.attribute_names.map { |attr| resource.send(attr) }
      end
    end
  end
end
