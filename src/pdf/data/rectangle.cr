require "../obj/renderable"
module PDF::Data
  # Rectangles are used to describe locations on a page and bounding boxes for a
  # variety of objects, such as fonts. A rectangle is written as an array of four numbers
  # giving the coordinates of a pair of diagonally opposite corners. Typically, the
  # array takes the form 
  # `[llx lly urx ury]`
  # specifying the lower-left x, lower-left y, upper-right x, and upper-right y coordinates of the rectangle, in that order. 
  # Note: Although rectangles are conventionally specified by their lower-left and upperright corners, 
  #it is acceptable to specify any two diagonally opposite corners. 
  #Applications that process PDF should be prepared to normalize such rectangles in situations
  # where specific corners are required.
  class Ractangle
    alias Number = Int64 | Float64
    getter llx
    getter lly
    getter urx
    getter ury

    def initizlize(@llx : Number ,@lly : Number ,@urx : Number ,@ury : Number)
    end
    #Typically, the array takes the form `[llx lly urx ury]`
    def format : String
      "[#{llx} #{lly} #{urx} #{ury}]"
    end

    def render_to_pdf(io : IO) : IO
      io << self.format
    end
    include Renderable
  end
end