# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: ignore
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/ruby_jard/all/ruby_jard.rbi
#
# ruby_jard-0.3.1

module RubyJard
  def self.all_files; end
  def self.benchmark(name); end
  def self.clear_debug; end
  def self.config; end
  def self.debug(*info); end
  def self.debug_info; end
  def self.error(exception); end
  def self.global_key_bindings; end
end
class RubyJard::PathClassifier
  def classify(path); end
  def fetch_gem_paths; end
  def initialize; end
  def try_classify_evaluation(path); end
  def try_classify_gem(path); end
  def try_classify_internal(path); end
  def try_classify_ruby_script(path); end
  def try_classify_source_tree(path); end
  def try_classify_stdlib(path); end
end
class RubyJard::PathFilter
  def initialize(config: nil, path_classifier: nil); end
  def match?(path); end
  def match_application?(path); end
  def match_everything?(path); end
  def match_excluded?(path, expand_path: nil); end
  def match_gems?(path); end
  def match_included?(path, expand_path: nil); end
  def match_source_tree?(path); end
end
class RubyJard::ControlFlow
  def arguments; end
  def command; end
  def initialize(command, arguments = nil); end
  def self.dispatch(command, arguments = nil); end
  def self.listen; end
  def validate!; end
end
class RubyJard::Config
  def alias_to_debugger; end
  def alias_to_debugger=(arg0); end
  def color_scheme; end
  def color_scheme=(arg0); end
  def config; end
  def enabled_screens; end
  def enabled_screens=(arg0); end
  def filter; end
  def filter=(arg0); end
  def filter_excluded; end
  def filter_excluded=(arg0); end
  def filter_included; end
  def filter_included=(arg0); end
  def initialize; end
  def layout; end
  def layout=(arg0); end
  def self.load_config(config, path); end
  def self.smart_load; end
end
class RubyJard::Keys
end
class RubyJard::KeyBinding
  def action; end
  def initialize(sequence, action); end
  def sequence; end
end
class RubyJard::KeyBindings
  def indexes; end
  def initialize; end
  def match(&read_key); end
  def push(sequence, action); end
  def reindex(key_binding); end
  def to_a; end
end
class RubyJard::Pager
  def enabled?; end
  def initialize(pry_instance); end
  def open(options = nil); end
  def page(text); end
end
class RubyJard::Pager::JardPageTracker < Pry::Pager::PageTracker
  def col; end
  def row; end
end
class RubyJard::Pager::LessPager < Pry::Pager::NullPager
  def close; end
  def initialize(pry_instance, force_open: nil, pager_start_at_the_end: nil, prompt: nil); end
  def invoked_pager?; end
  def list_prompt; end
  def open_pager; end
  def write(str); end
  def write_into_pager(str); end
end
class RubyJard::ReplProxy
  def handle_interrupt_command; end
  def handle_key_binding(key_binding); end
  def initialize(key_bindings: nil, input: nil, output: nil); end
  def listen_key_press; end
  def pry_command_set; end
  def pry_hooks; end
  def pry_instance; end
  def pry_jard_prompt; end
  def pry_pty_output; end
  def pry_repl(current_binding); end
  def read_key; end
  def repl(current_binding); end
  def write_output(content); end
end
class RubyJard::ReplProxy::FlowInterrupt < StandardError
  def flow; end
  def initialize(msg = nil, flow = nil); end
end
class RubyJard::ReplProxy::ReplState
  def check(method_name); end
  def exited!; end
  def exited?; end
  def exiting!; end
  def exiting?; end
  def initialize; end
  def processing!; end
  def processing?; end
  def ready!; end
  def ready?; end
end
class RubyJard::Console
  def self.attachable?; end
  def self.cached_tput; end
  def self.clear_screen(output); end
  def self.clear_screen_to_end(output); end
  def self.cooked!(output); end
  def self.disable_cursor!(output); end
  def self.disable_echo!(output); end
  def self.enable_cursor!(output); end
  def self.enable_echo!(output); end
  def self.getch(input, timeout); end
  def self.input; end
  def self.move_to(output, x, y); end
  def self.output; end
  def self.raw!(output); end
  def self.redirected?; end
  def self.screen_size(output); end
  def self.stty(*args); end
  def self.tput(*args); end
end
module RubyJard::Decorators
end
class RubyJard::Decorators::ColorDecorator
  def decorate(style_names, content); end
  def initialize(color_scheme); end
  def translate_color(color, foreground); end
  def translate_styles(styles = nil); end
end
class RubyJard::Decorators::PathDecorator
  def compact_with_relative_path(path); end
  def decorate(path, lineno = nil); end
  def decorate_gem(_path, lineno, info); end
  def decorate_source_tree(path, lineno); end
  def decorate_stdlib(_path, lineno, info); end
  def initialize(path_classifier: nil); end
end
class RubyJard::Decorators::LocDecorator
  def decorate(loc, file = nil); end
  def extension(file); end
  def initialize; end
end
class RubyJard::Decorators::LocDecorator::JardLocEncoder < CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(_kind); end
  def end_line(kind); end
  def open_token(kind); end
  def setup(options); end
  def text_token(text, kind); end
end
class RubyJard::Decorators::SourceDecorator
  def codes; end
  def decorate; end
  def initialize(file, lineno, window); end
  def window_end; end
  def window_start; end
end
class RubyJard::Decorators::ArrayDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def do_decorate_multiline(variable, lines:, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def last_line(total, item_count); end
  def match?(variable); end
  def same_type?(variable, sample); end
end
class RubyJard::Decorators::StringDecorator
  def decorate_multiline(variable, first_line_limit:, line_limit:, lines:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def match?(variable); end
end
class RubyJard::Decorators::HashDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def do_decorate_multiline(variable, lines:, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def last_line(total, item_count); end
  def match?(variable); end
end
class RubyJard::Decorators::StructDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def do_decorate_multiline(variable, lines:, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def last_line(total, item_count); end
  def match?(variable); end
end
class RubyJard::Decorators::ObjectDecorator
  def call_inspect(variable); end
  def decorate_custom_inspection(variable, line_limit:); end
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_native_inspection(variable, line_limit:, depth: nil, with_children: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def native_inspect?(variable); end
end
class RubyJard::Decorators::AttributesDecorator
  def arrow_span; end
  def ellipsis_span; end
  def indent_span; end
  def initialize(generic_decorator); end
  def inline_pairs(enum, total:, line_limit:, process_key:, value_proc: nil, depth: nil); end
  def inline_values(enum, total:, line_limit:, depth: nil); end
  def inspect_key(key, item_limit, process_key:, depth: nil); end
  def pair(key, value, line_limit:, process_key:, depth: nil); end
  def pair_limit(depth); end
  def separator_span; end
  def too_deep?(depth, line_limit); end
  def value(value, line_limit:, depth: nil); end
  def value_limit(_depth); end
end
class RubyJard::Decorators::RailsDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def match?(variable); end
end
class RubyJard::Decorators::RailsDecorator::ActiveRecordBaseDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def match?(variable); end
end
class RubyJard::Decorators::RailsDecorator::ActiveRecordRelationDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize(generic_decorator); end
  def match?(variable); end
  def relation_summary(variable, line_limit); end
end
class RubyJard::Decorators::InspectionDecorator
  def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: nil); end
  def decorate_primitive(variable, line_limit); end
  def decorate_singleline(variable, line_limit:, depth: nil); end
  def initialize; end
  def primitive?(variable); end
end
class RubyJard::Screen
  def build; end
  def click(relative_x, relative_y); end
  def cursor; end
  def cursor=(arg0); end
  def initialize(layout, session: nil); end
  def layout; end
  def layout=(arg0); end
  def move_down; end
  def move_up; end
  def page_down; end
  def page_up; end
  def rows; end
  def rows=(arg0); end
  def selected; end
  def selected=(arg0); end
  def window; end
  def window=(arg0); end
end
class RubyJard::Screens
  def [](name); end
  def add_screen(name, screen_class); end
  def get(name); end
  def initialize; end
  def names; end
  def self.[](*args, ****, &block); end
  def self.add_screen(*args, ****, &block); end
  def self.get(*args, ****, &block); end
  def self.instance; end
  def self.names(*args, ****, &block); end
end
class RubyJard::Screens::SourceScreen < RubyJard::Screen
  def build; end
  def handle_anonymous_evaluation; end
  def initialize(*args); end
  def loc_spans(loc); end
  def span_lineno(lineno); end
  def span_mark(lineno); end
  def title; end
end
class RubyJard::Screens::BacktraceScreen < RubyJard::Screen
  def build; end
  def initialize(*args); end
  def insert_current_frame; end
  def span_class_label(frame); end
  def span_frame_pos(frame); end
  def span_label_preposition; end
  def span_method_label(frame); end
  def span_path(frame); end
  def title; end
end
class RubyJard::Screens::ThreadsScreen < RubyJard::Screen
  def bool_to_int(bool); end
  def build; end
  def current_thread?(thread); end
  def initialize(*args); end
  def sort_threads(threads); end
  def span_mark(thread); end
  def span_thread_label(thread); end
  def span_thread_location(thread); end
  def span_thread_name(thread); end
  def span_thread_status(thread); end
  def thread_status_style(thread); end
  def title; end
end
class RubyJard::Screens::VariablesScreen < RubyJard::Screen
  def base_row(name, size, assignment, mark, base_inspection); end
  def build; end
  def fetch_constant(constant_source, const); end
  def fetch_constants; end
  def fetch_global_variables; end
  def fetch_instance_variables; end
  def fetch_local_variables; end
  def fetch_relevant_variables; end
  def generate_file_tokens(file); end
  def generate_inline_tokens(file, line); end
  def initialize(*args); end
  def inline?(name); end
  def nested_rows(variable, nested_inspections); end
  def relevant?(kind, name); end
  def self_variable; end
  def sort_variables(variables); end
  def span_mark(variable, nested_inspections); end
  def span_name(variable); end
  def span_size(variable); end
  def title; end
end
class RubyJard::Screens::MenuScreen < RubyJard::Screen
  def align(left_spans, right_spans); end
  def build; end
  def generate_left_spans; end
  def generate_right_spans; end
  def initialize(*args); end
end
class RubyJard::ColorScheme
  def initialize(styles: nil); end
  def styles_for(element); end
  def update(element, styles); end
end
class RubyJard::ColorSchemes
  def [](name); end
  def add_color_scheme(name, color_scheme_class); end
  def each(&block); end
  def get(name); end
  def initialize; end
  def length; end
  def names; end
  def self.[](*args, ****, &block); end
  def self.add_color_scheme(*args, ****, &block); end
  def self.each(*args, ****, &block); end
  def self.get(*args, ****, &block); end
  def self.instance; end
  def self.length(*args, ****, &block); end
  def self.names(*args, ****, &block); end
end
class RubyJard::ColorSchemes::DeepSpaceColorScheme < RubyJard::ColorScheme
end
class RubyJard::ColorSchemes::X256ColorScheme < RubyJard::ColorScheme
end
class RubyJard::ColorSchemes::X256LightColorScheme < RubyJard::ColorScheme
end
class RubyJard::ColorSchemes::GruvboxColorScheme < RubyJard::ColorScheme
end
class RubyJard::ColorSchemes::OneHalfDarkColorScheme < RubyJard::ColorScheme
end
class RubyJard::ColorSchemes::OneHalfLightColorScheme < RubyJard::ColorScheme
end
class RubyJard::Layout
  def box_height; end
  def box_height=(arg0); end
  def box_width; end
  def box_width=(arg0); end
  def box_x; end
  def box_x=(arg0); end
  def box_y; end
  def box_y=(arg0); end
  def height; end
  def height=(arg0); end
  def initialize(template: nil, parent_template: nil, width: nil, height: nil, x: nil, y: nil, box_width: nil, box_height: nil, box_x: nil, box_y: nil); end
  def parent_template; end
  def parent_template=(arg0); end
  def template; end
  def template=(arg0); end
  def width; end
  def width=(arg0); end
  def x; end
  def x=(arg0); end
  def y; end
  def y=(arg0); end
end
module RubyJard::Templates
end
class RubyJard::Templates::LayoutTemplate
  def children; end
  def fill_height; end
  def fill_width; end
  def height; end
  def height_ratio; end
  def initialize(height_ratio: nil, width_ratio: nil, min_width: nil, min_height: nil, height: nil, width: nil, children: nil, fill_width: nil, fill_height: nil); end
  def min_height; end
  def min_width; end
  def width; end
  def width_ratio; end
end
class RubyJard::Templates::ScreenTemplate
  def adjust_mode; end
  def height; end
  def height_ratio; end
  def initialize(screen: nil, row_template: nil, height_ratio: nil, width_ratio: nil, min_width: nil, min_height: nil, height: nil, width: nil, adjust_mode: nil); end
  def min_height; end
  def min_width; end
  def row_template; end
  def screen; end
  def width; end
  def width_ratio; end
end
class RubyJard::LayoutPicker
  def initialize(width, height, layouts: nil, config: nil); end
  def pick; end
end
class RubyJard::LayoutCalculator
  def adjust_layout_overlap(layout); end
  def calculate; end
  def calculate_child_height(child_template, parent_height); end
  def calculate_child_width(child_template, parent_width); end
  def calculate_layout(template, width, height, x, y, parent_template); end
  def initialize(layout_template:, width: nil, height: nil, x: nil, y: nil, config: nil); end
  def self.calculate(**args); end
  def stretch_children_layouts(parent_template, parent_width, parent_height, lines); end
  def visible?(template); end
  def visible_children(template); end
end
class RubyJard::Layouts
  def [](name); end
  def add_layout(name, layout_class); end
  def each(&block); end
  def fallback_layout; end
  def get(name); end
  def initialize(fallback_layout = nil); end
  def self.[](*args, ****, &block); end
  def self.add_layout(*args, ****, &block); end
  def self.each(*args, ****, &block); end
  def self.fallback_layout(*args, ****, &block); end
  def self.get(*args, ****, &block); end
  def self.instance; end
end
class RubyJard::Row
  def columns; end
  def columns=(arg0); end
  def content; end
  def content=(arg0); end
  def initialize(line_limit: nil, columns: nil, ellipsis: nil); end
  def line_limit; end
  def line_limit=(arg0); end
  def mark_rendered; end
  def rendered; end
  def rendered=(arg0); end
  def rendered?; end
  def reset_rendered; end
  extend Forwardable
end
class RubyJard::Column
  def content_length; end
  def content_length=(arg0); end
  def content_width; end
  def content_width=(arg0); end
  def initialize(spans: nil, word_wrap: nil); end
  def spans; end
  def spans=(arg0); end
  def width; end
  def width=(arg0); end
  def word_wrap; end
  def word_wrap=(arg0); end
  extend Forwardable
end
class RubyJard::Span
  def content; end
  def content=(arg0); end
  def content_length; end
  def content_length=(arg0); end
  def initialize(content: nil, content_length: nil, margin_left: nil, margin_right: nil, styles: nil); end
  def styles; end
  def styles=(arg0); end
  extend Forwardable
end
class RubyJard::RowRenderer
  def draw_content(drawing_content, styles); end
  def generate_bitmap; end
  def initialize(row:, width:, height:, color_scheme:); end
  def render; end
  def render_span(column, span); end
end
class RubyJard::ScreenRenderer
  def adjust_column_widths(column_widths); end
  def calculate_column_widths; end
  def calculate_content_lengths; end
  def calculate_window; end
  def count_columns; end
  def count_dynamic_columns(column_widths); end
  def find_cursor_window; end
  def find_seleted_window; end
  def initialize(screen:, color_scheme:); end
  def render; end
  def render_rows; end
  def row_content(row); end
  def sum_fixed_width(column_widths); end
end
class RubyJard::ScreenAdjuster
  def adjust; end
  def compact_screens(screens); end
  def expand_screens(expandable_screens, budget); end
  def expandable?(screen); end
  def initialize(screens); end
  def same_column?(screens); end
  def shrink_screens(shrinkable_screens); end
  def shrinkable?(screen); end
  def shrinkable_height(screen); end
end
class RubyJard::BoxDrawer
  def calculate_corners; end
  def colorize_border(content); end
  def draw; end
  def draw_basic_lines; end
  def draw_corners(corners); end
  def draw_titles; end
  def initialize(output:, screens:, color_scheme:); end
  def mark_corner(corners, x, y, id); end
end
class RubyJard::ScreenDrawer
  def draw; end
  def initialize(output:, screen:, color_scheme:); end
end
class RubyJard::ScreenManager
  def build_screens(layouts); end
  def calculate_layouts(width, height); end
  def click; end
  def draw_box(screens); end
  def draw_debug(_width, height); end
  def draw_error(exception, height = nil); end
  def draw_screens; end
  def fetch_screen(name); end
  def initialize(output: nil); end
  def output; end
  def output_storage; end
  def pick_color_scheme; end
  def render_screen(screen); end
  def scroll; end
  def self.draw_error(*args, ****, &block); end
  def self.draw_screens(*args, ****, &block); end
  def self.instance; end
  def self.puts(*args, ****, &block); end
  def self.start(*args, ****, &block); end
  def self.started?(*args, ****, &block); end
  def self.stop(*args, ****, &block); end
  def self.updating?(*args, ****, &block); end
  def start; end
  def started?; end
  def stop; end
  def total_screen_height(layouts); end
  def updating?; end
end
class RubyJard::Reflection
  def self.bind_call(owner, method_name, object, *args); end
  def self.call_class(object); end
  def self.call_const_defined?(object, const_name); end
  def self.call_const_get(object, const_name); end
  def self.call_inspect(object); end
  def self.call_instance_variable_get(object, variable); end
  def self.call_instance_variable_set(object, variable, value); end
  def self.call_instance_variables(object); end
  def self.call_is_a?(object, comparing_class); end
  def self.call_respond_to?(object, method_name); end
  def self.call_to_s(object); end
  def self.fetch_instance_method(object, method_name); end
  def self.fetch_method(object, method_name); end
  def self.instance_bind_call(owner, method_name, object, *args); end
end
class RubyJard::Frame
  def c_frame?; end
  def frame_binding; end
  def frame_class; end
  def frame_file; end
  def frame_line; end
  def frame_location; end
  def frame_method; end
  def frame_self; end
  def hidden?; end
  def initialize(context, real_pos, virtual_pos: nil); end
  def real_pos; end
  def thread; end
  def virtual_pos; end
  def virtual_pos=(arg0); end
  def visible=(arg0); end
  def visible?; end
end
class RubyJard::ThreadInfo
  def ==(other); end
  def alive?; end
  def backtrace_locations; end
  def id; end
  def initialize(thread); end
  def label; end
  def name; end
  def self.clear_labels; end
  def self.generate_label_for(id); end
  def self.labels; end
  def self.next_label; end
  def status; end
end
class RubyJard::Session
  def append_output_buffer(string); end
  def current_backtrace; end
  def current_frame; end
  def current_thread; end
  def frame=(real_pos); end
  def generate_backtrace; end
  def initialize(options = nil); end
  def lock; end
  def output_buffer; end
  def output_buffer=(arg0); end
  def self.append_output_buffer(*args, ****, &block); end
  def self.attach; end
  def self.current_backtrace(*args, ****, &block); end
  def self.current_frame(*args, ****, &block); end
  def self.current_thread(*args, ****, &block); end
  def self.frame=(*args, ****, &block); end
  def self.instance; end
  def self.lock(*args, ****, &block); end
  def self.output_buffer(*args, ****, &block); end
  def self.should_stop?(*args, ****, &block); end
  def self.step_into(*args, ****, &block); end
  def self.step_over(*args, ****, &block); end
  def self.sync(*args, ****, &block); end
  def self.threads(*args, ****, &block); end
  def should_stop?; end
  def start; end
  def started?; end
  def step_into(times); end
  def step_over(times); end
  def stop; end
  def sync(context); end
  def threads; end
end
class RubyJard::Error < StandardError
end
module Kernel
  def jard; end
end
