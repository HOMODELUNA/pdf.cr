require "./spec_helper"

describe PDF do; end

ideal_hello = <<-PDFFILE
%PDF-1.0
%âãÏÓ       
1 0 obj
<<
/Kids [2 0 R]
/Count 1
/Type /Pages
>>
endobj
2 0 obj
<<
/Rotate 0
/Parent 1 0 R
/Resources 3 0 R
/MediaBox [0 0 612 792]
/Contents [4 0 R]
/Type /Page
>>
endobj
3 0 obj
<<
/Font
<<
/F0
<<
/BaseFont /Times-Italic
/Subtype /Type1
/Type /Font
>>
>>
>>
endobj
4 0 obj
<<
/Length 65  
>>
stream
1. 0. 0. 1. 50. 700. cm
BT
 /F0 36. Tf
 (Hello, World!) Tj
ET

endstream
endobj
5 0 obj
<<
/Pages 1 0 R
/Type /Catalog
>>
endobj xref
0 6         
0000000000 65535 f
0000000015 00000 n
0000000074 00000 n
0000000192 00000 n
0000000291 00000 n
0000000409 00000 n
trailer

<<
/Root 5 0 R
/Size 6
>>
startxref
459         
%%EOF
PDFFILE
