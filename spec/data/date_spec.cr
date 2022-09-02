require "../../src/pdf/data/date"
describe PDF::Data::Date do
  it "format" do
    puts PDF::Data::Date.format(Time.local())
  end
end