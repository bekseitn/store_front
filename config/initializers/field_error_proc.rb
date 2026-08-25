# frozen_string_literal: true

# Rails' default field_error_proc wraps any invalid field in
# `<div class="field_with_errors">`, which breaks Bootstrap 5's CSS
# (`.is-invalid ~ .invalid-feedback`) since it needs the invalid input and
# its feedback div to be direct siblings - found by actually submitting an
# invalid form and inspecting the rendered HTML, not by reading the code
# (the red border/icon still showed, from :invalid pseudo-class matching
# regardless of DOM nesting - only the feedback text was silently hidden).
ActiveSupport.on_load(:action_view) do
  ActionView::Base.field_error_proc = proc { |html_tag, _instance| html_tag }
end
