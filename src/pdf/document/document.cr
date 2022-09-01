require "./header"
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
  class Document
    #提供PDF版本号
    @header : Header
    #包含页面，图形内容和大部分辅助信息的主体，全部编码为一系列对象。
    @body=0
    #交叉引用表，列出文件中每个对象的位置便于随机访问。
    @crossrefs =0
    #trailer字典，它有助于找到文件的每个部分， 并列出可以在不处理整个文件的情况下读取的各种元数据。
    @trailers =0
    def initialize(@header,@boty,@crossrefs,@trailers)
    end

    # 将PDF文档写入文件中的一系列字节要比阅读它简单得多， 我们不需要支持所有PDF格式，只需要支持我们打算使用的子集。写作 PDF文件非常快，因为它只是将对象图展平为一系列字节。
    #
    #- 输出header。
    #- 删除PDF中任何其他对象未引用的任何对象。这个避免编写不再需要的对象。
    #- 重新编号对象，使它们从1到n运行，其中n是对象的数量文件。
    #- 逐个输出对象，从对象编号1开始，记录字节交叉引用表的每个偏移量。
    #- 编写交叉引用表。
    #- 编写trailer，trailer字典和文件结束标记
    def render(io : IO)
      @header.render(io)

      io<<"%%EOF"
    end
  end
end
    