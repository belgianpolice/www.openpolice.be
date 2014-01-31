require 'sinatra'
require 'kss'

get '/' do
  erb :index
end

get '/buttons' do
  @styleguide = Kss::Parser.new('public/stylesheets')
  erb :buttons
end

get '/forms' do
  @styleguide = Kss::Parser.new('public/stylesheets')
  erb :forms
end

get '/media' do
  @styleguide = Kss::Parser.new('public/stylesheets')
  erb :media
end

get '/navigation' do
  @styleguide = Kss::Parser.new('public/stylesheets')
  erb :navigation
end

helpers do
  # Generates a styleguide block. A little bit evil with @_out_buf, but
  # if you're using something like Rails, you can write a much cleaner helper
  # very easily.
  def styleguide_block(section, &block)
    @section = @styleguide.section(section)
    @example_html = capture{ block.call }
    @escaped_html = ERB::Util.html_escape @example_html
    @_out_buf << erb(:_styleguide_block)
  end

  # Captures the result of a block within an erb template without spitting it
  # to the output buffer.
  def capture(&block)
    out, @_out_buf = @_out_buf, ""
    yield
    @_out_buf
  ensure
    @_out_buf = out
  end
end
