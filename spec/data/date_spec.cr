require "../../src/pdf/data/date"
describe PDF::Date do
  it "format" do
    puts PDF::Date.format(Time.local())
  end
end