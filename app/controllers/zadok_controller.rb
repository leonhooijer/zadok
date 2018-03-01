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

  def index
    respond_to do |format|
      format.csv { send_data(generate_csv) }
      format.html do
        filter_and_paginate_resources!
        render "zadok/index"
      end
      format.json { render json: resources, root: false }
      format.xml { render xml: resources.map(&:attributes), root: controller_name }
    end
  end

  def show
    respond_to do |format|
      format.html { render "zadok/show" }
      format.json { render json: resource, root: false }
      format.xml { render xml: resource.attributes, root: controller_name.singularize }
    end
  end

  def new
    render "zadok/new"
  end

  def create
    if resource.save
      flash.now[:success] = t("#{controller_name}.create_success")
      flash.keep(:success)
      redirect_to url_for(controller: controller_name, action: :index)
    else
      flash.now[:danger] = resource.errors.full_messages.join("<br />")
      render "zadok/new"
    end
  end

  def edit
    render "zadok/edit"
  end

  def update
    if resource.update(resource_params)
      flash.now[:success] = t("#{controller_name}.update_success")
    else
      flash.now[:danger] = resource.errors.full_messages.join("<br />")
    end
    render "zadok/edit"
  end

  def destroy
    if resource.destroy
      flash.now[:success] = t("#{controller_name}.destroy_success")
      flash.keep(:success)
    else
      flash.now[:danger] = resource.errors.full_messages.join("<br />")
      flash.keep(:danger)
    end
    redirect_to url_for(controller: controller_name, action: :index)
  end

  protected

  def filter_collection
    Zadok::FilterCollection.new(search_params, filters_namespace)
  end

  def filters_namespace
    "zadok/filters/#{controller_name}".classify.constantize
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
    permitted_params.fetch(:page) { nil }
  end

  def per_page
    permitted_params.fetch(:per_page) { 30 }
  end

  def current_sort
    search_params.fetch(:s) { nil }
  end

  def permitted_params
    params.permit(:page, :per_page, q: %i[s search_model])
  end

  def resource_params
    send("#{controller_name.singularize}_params")
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

  def page_title
    t("#{controller_name}.#{action_name}")
  end

  def resources
    raise "resources method not implemented"
  end

  def filter_and_paginate_resources!
    raise "filter_and_paginate_resources! method not implemented"
  end

  def resource
    raise "resource method not implemented"
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
        [attr, type.class.name.demodulize.downcase]
      end
    ]
  end

  def edit_attributes
    Hash[
      resource_class.attribute_types.map do |attr, type|
        [attr, type.class.name.demodulize.downcase]
      end
    ]
  end

  def generate_csv
    CSV.generate(headers: true, col_sep: t("zadok.csv.col_sep")) do |csv|
      csv << resource_class.attribute_names

      resources.each do |resource|
        csv << resource_class.attribute_names.map { |attr| resource.send(attr) }
      end
    end
  end
end
