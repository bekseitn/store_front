# frozen_string_literal: true

module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active list-group-item' : 'list-group-item'
    link_to link_text, link_path, class: class_name
  end
end
