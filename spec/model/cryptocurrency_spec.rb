require "rails_helper"
RSpec.describe Cryptocurrency, type: :model do
  subject {Cryptocurrency.new(name: "TestName", market_cap: "123456", price: "12", volume: "1234", circulating_supply: "123456789", change: "12")}

  before {subject.save}

  it "name should be present" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "price should be present" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "subject should be valid" do
    expect(subject).to be_valid
  end
end