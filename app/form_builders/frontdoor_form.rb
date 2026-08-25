# frozen_string_literal: true

# Custom Bootstrap 5 form builder, per GUIDELINES.md: call sites use
# `f.group`/`f.label`/`f.input`/`f.errors` and never add Bootstrap classes
# (form-label/form-control/form-select) themselves - this builder adds them
# internally so every form stays visually consistent.
#
# Typical usage:
#   = f.group(:name, class: "col-md-6") do
#     = f.label :name, "Customer name"
#     = f.input :name
#     = f.errors :name
#
# `input` picks a text_field for plain attributes and a collection_select
# (with `form-select`) for belongs_to associations, e.g. `f.input :city,
# include_blank: "Select a city"`.
class FrontdoorForm < ActionView::Helpers::FormBuilder
  def group(_attribute, **html_options, &)
    css = merge_classes('mb-3', html_options.delete(:class))
    @template.content_tag(:div, @template.capture(&), html_options.merge(class: css))
  end

  def label(attribute, text = nil, **options)
    css = merge_classes('form-label', options.delete(:class))
    # For a belongs_to attribute, `input` renders the actual <select> keyed
    # on the foreign key (see collection_input) - point `for=` at that same
    # id, not the association name, or clicking the label won't focus it.
    options[:for] ||= field_id(input_target(attribute))
    super(attribute, text, options.merge(class: css))
  end

  def input(attribute, **options)
    reflection = association_reflection(attribute)

    if reflection
      collection_input(attribute, reflection, **options)
    else
      css = merge_classes('form-control', invalid_class(attribute), options.delete(:class))
      text_field(attribute, options.merge(class: css))
    end
  end

  def errors(attribute)
    return ''.html_safe unless invalid?(attribute)

    @template.content_tag(:div, object.errors[attribute].to_sentence.capitalize, class: 'invalid-feedback')
  end

  private

  def collection_input(attribute, reflection, **options)
    select_options = options.slice(:include_blank, :prompt)
    html_options = options.except(:include_blank, :prompt)
    html_options[:class] = merge_classes('form-select', invalid_class(attribute), html_options[:class])
    # Submit the foreign key (e.g. `city_id`), not the association name -
    # collection_select takes `method` literally as the param key, it
    # doesn't know `:city` means "really submit city_id" on its own. Found
    # by inspecting the rendered <select>'s actual name= attribute, which
    # silently didn't match what the controller's permit list expects.
    collection_select(reflection.foreign_key, reflection.klass.all, :id, :name, select_options, html_options)
  end

  def input_target(attribute)
    association_reflection(attribute)&.foreign_key || attribute
  end

  def invalid?(attribute)
    object.respond_to?(:errors) && object.errors[attribute].present?
  end

  def invalid_class(attribute)
    'is-invalid' if invalid?(attribute)
  end

  def association_reflection(attribute)
    object.class.try(:reflect_on_association, attribute)
  end

  def merge_classes(*classes)
    classes.compact.join(' ')
  end
end
