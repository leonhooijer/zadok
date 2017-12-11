# frozen_string_literal: true

require "will_paginate/view_helpers/action_view"

module Zadok
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag(:nav, tag(:ul, html, container_attributes))
    end

    def page_number(page)
      if page == current_page
        link_tag = tag(:span, page, class: "page-link")
        css_class = "active"
      else
        css_class = ""
        link_tag = link(page, page, rel: rel_value(page), class: "page-link")
      end
      tag(:li, link_tag, class: "page-item #{css_class}")
    end

    def previous_or_next_page(page, text, css_class)
      link_tag = if page

                   link(text, page, class: "page-link")
                 else
                   css_class = "disabled"
                   tag(:span, text, class: "page-link")
                 end
      tag(:li, link_tag, class: "page-item #{css_class}")
    end

    def gap
      span_tag = tag(:span, "&hellip;", class: "page-link")
      tag(:li, span_tag, class: "page-item disabled")
    end
  end
end
