#This module means some Type that can be rendered into an io ,and therefore can be formatted to a string
#
# We'll overload `IO#<<` for classes including this module
#
#To include this module,a class must have a `#render_to_pdf` method, which seems like
#```crystal
#  def render_to_pdf(io : IO) : IO
#```
#it means putting all the required data into an io.
#unless explicitly required, the output **does** contains a newline
module PDF::Renderable
  #render your data into a pdf file , and return the rendered IO
  abstract def render_to_pdf(io : IO) : IO
end

#Here we overload the method
class ::IO
  def <<(pdf_obj : PDF::Renderable)
    pdf_obj.render_to_pdf(self)
    self
  end
  end
