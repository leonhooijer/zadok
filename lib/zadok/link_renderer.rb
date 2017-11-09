# frozen_string_literal: true

require "will_paginate/view_helpers/action_view"

module Zadok
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag(:nav, tag(:ul, html, container_attributes))
    end

    def page_number(page)
      css_class = page == current_page ? "page-item active" : "page-item"
      tag(:li, link(page, page, rel: rel_value(page), class: "page-link"), class: css_class)
    end

    def previous_or_next_page(page, text, css_class)
      css_class += " disabled" unless page
      tag(:li, link(text, page || "#", class: "page-link"), class: "page-item #{css_class}")
    end

    def gap
      tag(:li, tag(:span, "&hellip;"))
    end
  end
end
