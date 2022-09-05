require "../spec_helper"
alias CrossRef = PDF::Document::CrossRef
describe PDF::Document::CrossRef do
  
  it "outputs" do 
    arr = [
      CrossRef::Entry.new(0,65535,false),
      CrossRef::Entry.new(25325),
      CrossRef::Entry.new(25518 , 2),
      CrossRef::Entry.new(25635),
      CrossRef::Entry.new(25177),
    ]
    CrossRef.new(arr).render_to_pdf(STDOUT)
  end
end
