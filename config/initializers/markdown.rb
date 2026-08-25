# frozen_string_literal: true

# GUIDELINES.md's i18n convention: a locale key suffixed `_md` is authored
# in Markdown instead of plain text/HTML, and `t("...")` renders it to HTML
# automatically (marked html_safe). Multiline strings (paragraphs separated
# by a blank line) keep their <p> tags; a single-line string is unwrapped
# from the single <p> Markdown would otherwise add around it, so it reads
# as an inline fragment. Non-`_md` keys are returned untouched, exactly as
# `t` normally behaves.
module MarkdownTranslationHelper
  RENDERER = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, no_intra_emphasis: true)

  def translate(key, **options)
    result = super

    return result unless key.to_s.end_with?('_md') && result.is_a?(String)

    render_markdown(result)
  end
  alias t translate

  private

  def render_markdown(text)
    html = RENDERER.render(text).strip
    multiline = text.strip.include?("\n\n")
    html = html.sub(%r{\A<p>(.*)</p>\z}m, '\1') unless multiline
    html.html_safe
  end
end

ActiveSupport.on_load(:action_view) do
  include MarkdownTranslationHelper
end
