module Renderable
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  def self.renderer
    @renderer ||= Redcarpet::Markdown.new(GithubHTML, 
          :autolink => true, 
          :space_after_headers => true,
          :fenced_code_blocks => true)
  end

  module ClassMethods
    
    def renderable(*args)
      args.each do |arg|
        define_method("rendered_#{arg}") do
          Rails.cache.fetch("#{arg.to_s}:#{id}:#{updated_at}") do
            Renderable.renderer.render(self.send(arg)).html_safe
          end
        end
      end
    end

  end
end