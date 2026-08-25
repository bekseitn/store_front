# frozen_string_literal: true

# will_paginate-bootstrap's own renderer (BootstrapPagination::Rails) predates
# Bootstrap 4/5's `page-item`/`page-link` classes - without them, Bootstrap
# 5's CSS doesn't style the pagination at all (it renders bare <li>/<a>
# elements under `.pagination`, which BS5 doesn't target). This reuses its
# tree shape and just adds the classes BS5 actually needs.
class Bootstrap5PaginationRenderer < BootstrapPagination::Rails
  protected

  def page_number(page)
    link_options = @options[:link_options] || {}

    if page == current_page
      tag('li', tag('span', page, class: 'page-link'), class: 'page-item active')
    else
      tag('li', link(page, page, link_options.merge(class: 'page-link', rel: rel_value(page))),
          class: 'page-item')
    end
  end

  def previous_or_next_page(page, text, classname)
    link_options = @options[:link_options] || {}

    if page
      tag('li', link(text, page, link_options.merge(class: 'page-link')), class: "page-item #{classname}")
    else
      tag('li', tag('span', text, class: 'page-link'), class: "page-item #{classname} disabled")
    end
  end

  def gap
    tag('li', tag('span', ELLIPSIS, class: 'page-link'), class: 'page-item disabled')
  end
end
