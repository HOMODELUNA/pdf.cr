module PDF
  class Document
    # The trailer of a PDF file enables an application reading the file to quickly find the
    # cross-reference table and certain special objects. Applications should read a PDF
    # file from its end. The last line of the file contains only the end-of-file marker,
    # %%EOF. (See implementation note 15 in Appendix H.) The two preceding lines
    # contain the keyword **startxref** and the byte offset from the beginning of the file to
    # the beginning of the xref keyword in the last cross-reference section. 
    #The **startxref** line is preceded by the trailer dictionary, 
    #consisting of the keyword trailer followed by a series of key-value pairs enclosed in double angle brackets. 
    #Thus the trailer has the following overall structure:
    #```plaintext
    #trailer
    #  << key1 value1
    #     key2 value2 …
    #     keyn valuen
    #  >>
    #startxref
    #Byte_offset_of_last_cross-reference_section
    #%%EOF
    #```
    # Here is a factual trailer:
    #```
    # trailer
    # << /Size 22
    #  /Root 2 0 R
    #  /Info 1 0 R
    #  /ID [ <81b14aafa313db63dbd6f981e49f94f4>
    # <81b14aafa313db63dbd6f981e49f94f4>
    # ]
    # >>
    # startxref
    # 18799
    # %%EOF
    #```
    class Trailer
      # The total number of entries in the file’s cross-reference table, as defined
      # by the combination of the original section and all update sections. Equivalently, this
      # value is 1 greater than the highest object number used in the file. 
      def size
      end
      # (Present only if the file has more than one cross-reference section) The byte offset from
      # the beginning of the file to the beginning of the previous cross-reference section. 
      # Root dictionary (Required; must be an indirect reference) The catalog object for the PDF document
      # contained in the file (see Section 3.6.1, “Document Catalog”). 
      @prev : Int64?
      #(Required if document is encrypted; PDF 1.1) The document’s encryption dictionary (see Section 3.5, “Encryption”). 
      @encrypt : Hash(String,PdfObj)?
      #(Optional; must be an indirect reference) The document’s information dictionary
      #(see Section 8.2, “Document Information Dictionary”). 
      @info : Hash(String,PdfObj)?
      # An array of two strings, each of which is a file identifier (see
      # Section 8.3, “File Identifiers”). The first identifier is established permanently when
      # the file is created; the second is changed each time the file is updated.
      #TODO: FileIdentifier
      @id : Array(String)?

    end
  end
end