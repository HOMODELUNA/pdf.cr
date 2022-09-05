require "./spec_helper"
describe PDF::PdfObj do
  it "output nil" do
    PDF::PdfObj.raw_output(nil,STDOUT);puts ""
  end
  it "output integer" do
    PDF::PdfObj.raw_output(1111_i64,STDOUT) ;puts ""
  end
  it "output float" do
    PDF::PdfObj.raw_output(12.34,STDOUT);puts ""
  end
  it "output string" do 
    PDF::PdfObj.raw_output("abc(%scc  2)",STDOUT);puts ""
  end
end