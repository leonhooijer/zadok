# frozen_string_literal: true

module ZadokHelper
  def resource_url_for(action)
    url_for(controller: controller_name, action: action)
  end

  def sort_table_header(attr, model)
    name = t("activerecord.attributes.#{model}.#{attr}")

    cell_contents = if current_sort == "#{attr} asc"
                      [name, icon(:fas, "chevron-down", class: "float-right")]
                    elsif current_sort == "#{attr} desc"
                      [name, icon(:fas, "chevron-up", class: "float-right")]
                    else
                      [name]
                    end

    content_tag(:th, class: "sortable", data: { href: sort_url(current_search, attr) }) do
      safe_join(cell_contents, " ")
    end
  end
end
