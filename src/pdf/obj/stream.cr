require "./name"
module PDF
  #A stream object, like a string object, is a sequence of bytes. 
  #However, a PDF application can read a stream incrementally, while a string must be read in its entirety.
  #
  #Furthermore, a stream can be of unlimited length, whereas a string is subject to
  #an implementation limit. For this reason, objects with potentially large amounts
  #of data, such as images and page descriptions, are represented as streams. 
  #
  #*Note*: As with strings, this section describes only the syntax for writing a stream as a
  #sequence of bytes. What those bytes represent is determined by the context in which
  #the stream is referenced.
  #
  #example:
  #```plaintext
  #  << /Length 534
  # /Filter [/ASCII85Decode /LZWDecode]
  #>>
  #stream
  #J..)6T`?p&<!J9%_[umg"B7/Z7KNXbN'S+,*Q/&"OLT'F
  #LIDK#!n`$"<Atdi`\Vn%b%)&'cA*VnK\CJY(sF>c!Jnl@
  #RM]WM;jjH6Gnc75idkL5]+cPZKEBPWdR>FF(kj1_R%W_d
  #&/jS!;iuad7h?[L−F$+]]0A3Ck*$I0KZ?;<)CJtqi65Xb
  #Vc3\n5ua:Q/=0$W<#N3U;H,MQKqfg1?:lUpR;6oN[C2E4
  #ZNr8Udn.'p+?#X+1>0Kuk$bCDF/(3fL5]Oq)^kJZ!C2H1
  #'TO]Rl?Q:&'<5&iP!$Rq;BXRecDN[IJB`,)o8XJOSJ9sD
  #S]hQ;Rj@!ND)bD_q&C\g:inYC%)&u#:u,M6Bm%IY!Kb1+
  #":aAa'S`ViJglLb8<W9k6Yl\\0McJQkDeLWdPN?9A'jX*
  #al>iG1p&i;eVoK&juJHs9%;Xomop"5KatWRT"JQ#qYuL,
  #JD?M$0QP)lKn06l1apKDC@\qJ4B!!(5m+j.7F790m(Vj8
  #8l8Q:_CZ(Gm1%X\N1&u!FKHMB~>
  #endstream
  #```
  class Stream
    @dict : Hash(String , PdfObj)
    @bytes : Array(UInt8) = [] of UInt8 
    # The number of bytes from the beginning of the line following the keyword stream to the last byte just before the keyword
    # endstream. (There may be an additional EOL marker, preceding endstream, that is not included in the count and is not logically part of
    # the stream data.) 
    def length
      @bytes.size
    end
    # Filter name or array (Optional) The name of a filter to be applied in processing the stream
    # data found between the keywords stream and endstream, or an array
    # of such names. Multiple filters should be specified in the order in
    # which they are to be applied. 
    @filter : Name | Array(Name) | Nil
    
    # A parameter dictionary, or an array of such dictionaries,
    # used by the filters specified by Filter. If there is only one filter and that
    # filter has parameters, DecodeParms must be set to the filter’s parameter dictionary unless all the filter’s parameters have their default
    # values, in which case the DecodeParms entry may be omitted. If there
    # are multiple filters and any of the filters has parameters set to nondefault values, DecodeParms must be an array with one entry for
    # each filter: either the parameter dictionary for that filter, or the null
    # object if that filter has no parameters (or if all of its parameters have
    # their default values). If none of the filters have parameters, or if all
    # their parameters have default values, the DecodeParms entry may be
    # omitted. (See implementation note 6 in Appendix H.) 
    @decode_params : Hash(String,PdfObj) | Array(PdfObj) | Nil

    property :filter,decode_params
    # the file containing the stream data. 
    # If this entry is present, the bytes between stream and endstream are ignored, 
    # the filters are specified by FFilter rather than Filter, 
    # and the filter parameters are specified by FDecodeParms rather than DecodeParms. 
    # However, the Length entry should still specify the number of those bytes.
    # (Usually there are no bytes and Length is 0.) 
    @file_specification : String?

    #The name of a filter to be applied in processing
    #the data found in the stream’s external file, or an array of such names.
    #The same rules apply as for Filter. 
    @ffilter : Array(Name)? 
    #A parameter dictionary, or an array of such dictionaries, used by the filters specified by FFilter. 
    #The same rules apply as for DecodeParms.
    @fdecode_params : Hash(String,PdfObj) | Array(PdfObj) | Nil

    #dict中不必指明字节数,因为计算时可以推出来
    def initialize(@dict,@bytes)
      
    end
    #print keyword and boty bytes
    #TODO:add filter and cryptor
    def raw_output(io : IO)
      io<<"stream\n";
      #TODO: add filter and cryptor
      io <<"\nendstream\n"
    end
  end
end