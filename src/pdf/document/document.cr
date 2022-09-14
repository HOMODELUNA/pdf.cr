require "./header"
require "./pagetree"
require "./crossref"
require "./trailer"
require "../obj/renderable"
module PDF
  #A canonical PDF file initially consists of four elements : 
  #- A one-line header identifying the version number of the PDF specification to which the file conforms 
  #- A body containing the objects that make up the document contained in the file 
  #- A cross-reference table containing information about the indirect objects in the file 
  #- A trailer giving the location of the cross-reference table and of certain special objects within the body of the file
  #
  # The body of a PDF file consists of a sequence of indirect objects representing the
  # contents of a document. The objects, which are of the basic types described in
  # Section 3.2, “Objects,” represent components of the document such as fonts,
  # pages, and sampled images.
  # 
  # in the code we should pretain the document structure, not the actual text te output.
  # the real form will be generated at render time
  class Document
    EOF = "%%EOF"
    #提供PDF版本号
    @header : Header
    #包含页面，图形内容和大部分辅助信息的主体，全部编码为一系列对象。
    @body : Catalog
    def crossrefs(ids : Hash(Object,Int32)) : CrossRef
    end
    #交叉引用表，列出文件中每个对象的位置便于随机访问。
    #@crossrefs : CrossRef
    #trailer字典，它有助于找到文件的每个部分， 并列出可以在不处理整个文件的情况下读取的各种元数据。
    @trailers : Trailer
    def initialize(@header,@body,@crossrefs,@trailers)
    end

    # Outputing a pdf into bytes is easier than reading it. We needn't support all pdf formats,but just our subset to use.
    # 
    # writing a pdf is really fast,because it's just flatten objects into some bytes.
    #
    #- output header。
    #- remove all unuesed objects
    #- renumber objects from 1 to n
    #- output objects from number 1, counting each obj in the crossref
    #- output crossref
    #- output trailer, and trailer dictionary
    #- output EOF
    def render_to_pdf(io : IO)
      header_str = String.build
      @header.render(io)
      id_table = {} of UInt32 => Renderable
      @catalog.register_to_id_table(id_table)
      id_table.each do |id,object|
        io << id <<" 0 obj\n"
        object.render_to_pdf(io)
        io.puts("endobj")
      end
      # output objects from number 1, counting each obj in the crossref
      # output crossref
      io << self.crossrefs()
      io<< @trailer
      io<<"%%EOF"
    end
  end
end
    