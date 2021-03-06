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
          if self.send(arg)
            Renderable.renderer.render(self.send(arg)).html_safe
          else
            ""
          end
        end
      end
    end

  end
end