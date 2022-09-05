require "../obj/renderable"
module PDF
  class Document
    # The cross-reference table contains information that permits random access to indirect objects within the file, 
    # so that the entire file need not be read to locate any particular object. 
    # The table contains a one-line entry for each indirect object,
    # specifying the location of that object within the body of the file. 
    #
    # The cross-reference table is the only part of a PDF file with a fixed format; 
    # thispermits entries in the table to be accessed randomly. 
    # The table comprises one ormore cross-reference sections. 
    # Initially, the entire table consists of a single section;
    # one additional section is added each time the file is updated (see Section 3.4.5,“Incremental Updates”). 
    #
    # Each cross-reference section begins with a line containing the keyword xref. 
    # Following this line are one or more cross-reference subsections, which may appear in any order. 
    # The subsection structure is useful for incremental updates, 
    # since it allows a new cross-reference section to be added to the PDF file, 
    # containing entries only for objects that have been added or deleted. 
    # For a file that has never been updated, the cross-reference section contains only one subsection, 
    # whose object numbering begins at 0.
    #
    # Each cross-reference subsection contains entries for a contiguous range of object numbers. 
    # The subsection begins with a line containing two numbers, separated by a space: 
    # the object number of the first object in this subsection and the number of entries in the subsection. 
    # For example, the line `28 5`
    # introduces a subsection containing five objects, numbered consecutively from 28 to 32.
    #
    # An overall example seems like:
    #```plaintext
    #    xref
    #0 1
    #0000000000 65535 f
    #3 1
    #0000025325 00000 n
    #23 2
    #0000025518 00002 n
    #0000025635 00000 n
    #30 1
    #0000025777 00000 n
    #```
    class CrossRef
      struct Entry
        EOL = "\r\n"
        @target : Int32 = 0
        @generation : Int32 = 0
        @using : Bool = true 
        getter :entry ,:generation , :using 
        def initialize(@target,@generation = 0 , @using = true)
          if @target >= 1e10
            raise "the target \"#{@target}\"is bigger then 10 digits"
          elsif @generation > 65535
            raise "the generation number \"#{@generation}\"is bigger than 65535"
          end
        end
        # The format of an in-use entry is as follows: 
        #
        # `nnnnnnnnnn ggggg n eol`
        #
        # where 
        #- `nnnnnnnnnn` is a 10-digit byte offset 
        #- `ggggg` is a 5-digit generation number 
        #- `n` is a literal keyword identifying this as an in-use entry ,for a free entry use `f`
        #- `eol` is a 2-character end-of-line sequence
        #
        # because a n EOL is just "\r\n",you won't need to add a newline manually
        def render_to_pdf(io : IO) : IO
          @target.to_s(io,precision: 10)
          io<<' '
          @generation.to_s(io,precision: 5)
          io<<' '<<(@using ? 'n' : 'f') << EOL
        end
        include Renderable
      end

      START = 0
      @entries : Array(Entry) 

      def initialize(@entries)
      
      end

      def size
        @entries.size
      end

      def render_to_pdf(io : IO) : IO
        io<< START << ' '<< self.size()<<'\n'
        @entries.each do |en|
          io << en
        end
        io
      end
    end
  end  
  
end