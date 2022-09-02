module PDF
  #The leaves of the page tree are page objects, 
  # each of which is a dictionary specifying the attributes of a single page of the document. Table 3.17 shows the contents
  # of this dictionary (see also implementation note 19 in Appendix H). The table
  # also identifies which attributes a page may inherit from its ancestor nodes in the
  # page tree, as described under “Inheritance of Page Attributes” on page 80.
  # Attributes that are not explicitly identified in the table as inheritable cannot be
  # inherited.
  class Page
    #The type of PDF object that this dictionary describes; must be *Page* for a page object. 
    TYPE = Name.new("Page")
    #:ditto:
    def type
      TYPE
    end
    #(Required; must be an indirect reference) The page tree node that is the immediate parent of this page object. 
    @parent
    #Resources dictionary (Required; inheritable) A dictionary containing any resources required by
    #the page (see Section 3.7.2, “Resource Dictionaries”). If the page requires
    #no resources, the value of this entry should be an empty dictionary; omitting the entry entirely, or specifying a null value, indicates that the resources are to be inherited from an ancestor node in the page tree.
    @resources =0
    # (Required; inheritable) A rectangle (see Section 3.8.3, “Rectangles”), expressed in default user space units,
    # defining the maximum imageable area of the physical medium on which the page is to be printed 
    # (seeSection 8.6.1, “Page Boundaries”). 
#     @MediaBox :  Rectangle

# CropBox rectangle (Optional; inheritable) A rectangle, expressed in default user space units,
# defining the region to which the contents of the page are to be clipped
# (cropped) when displayed or printed (see Section 8.6.1, “Page Boundaries”). Default value: the value of MediaBox. 
# BleedBox rectangle (Optional; PDF 1.3) A rectangle, expressed in default user space units, de-
# fining the region to which the contents of the page should be clipped
# when output in a production environment (see Section 8.6.1, “Page
# Boundaries”). Default value: the value of CropBox. 
# TrimBox rectangle (Optional; PDF 1.3) A rectangle, expressed in default user space units, de-
# fining the intended dimensions of the finished page after trimming (see
# Section 8.6.1, “Page Boundaries”). Default value: the value of CropBox. 
# ArtBox rectangle (Optional; PDF 1.3) A rectangle, expressed in default user space units, de-
# fining the extent of the page’s meaningful content (including potential
# white space) as intended by the page’s creator (see Section 8.6.1, “Page
# Boundaries”). Default value: the value of CropBox. 
# Contents stream or array (Optional) A content stream (see Section 3.7.1, “Content Streams”) describing the contents of this page. If this entry is absent, the page is empty. 
# The value may be either a single stream or an array of streams. If it is an
# array, the effect is as if all of the streams in the array were concatenated, in
# order, to form a single stream. This allows a program generating a PDF
# file to create image objects and other resources as they occur, even though
# they interrupt the content stream. The division between streams may
# occur only at the boundaries between lexical tokens (see Section 3.1,
# “Lexical Conventions”), but is unrelated to the page’s logical content or
# organization. Applications that consume or produce PDF files are not required to preserve the existing structure of the Contents array. 
# Rotate integer (Optional; inheritable) The number of degrees by which the page should
# be rotated clockwise when displayed or printed. The value must be a multiple of 90. Default value: 0. 
# Thumb stream (Optional) A stream object defining the page’s thumbnail image (see
# Section 7.2.3, “Thumbnail Images”). 
# B array (Optional; PDF 1.1; recommended if the page contains article beads) An
# array of indirect references to article beads appearing on the page (see
# Section 7.3.2, “Articles”; see also implementation note 20 in Appendix H).
# The beads are listed in the array in natural reading order.
    
  end
end