# frozen_string_literal: true

class ZadokController < ApplicationController
  helper_method :edit_attributes
  helper_method :index_attributes
  helper_method :new_attributes
  helper_method :resource
  helper_method :resource_name
  helper_method :resources
  helper_method :show_attributes

  def show
    render "zadok/show"
  end

  def index
    filter_and_paginate_resources!
    render "zadok/index"
  end

  def new
    render "zadok/new"
  end

  def create
    if resource.save
      flash.now[:success] = t("#{resource_name.pluralize}.create_success")
      flash.keep(:success)
      redirect_to url_for(controller: resource_name.pluralize, action: :index)
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
      flash.now[:success] = t("#{resource_name.pluralize}.update_success")
    else
      flash.now[:danger] = resource.errors.full_messages.join("<br />")
    end
    render "zadok/edit"
  end

  def destroy
    if resource.destroy
      flash.now[:success] = t("#{resource_name.pluralize}.destroy_success")
      flash.keep(:success)
    else
      flash.now[:danger] = resource.errors.full_messages.join("<br />")
      flash.keep(:danger)
    end
    redirect_to url_for(controller: resource_name.pluralize, action: :index)
  end

  protected

  def permitted_params
    params.permit(:page, :per_page, q: %i[s search_model])
  end

  def resource_params
    raise "resource_params method not implemented"
  end

  def resource_name
    raise "resource_name method not implemented"
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
    raise "show_attributes method not implemented"
  end

  def index_attributes
    raise "index_attributes method not implemented"
  end

  def new_attributes
    raise "new_attributes method not implemented"
  end

  def edit_attributes
    raise "edit_attributes method not implemented"
  end
end
