# frozen_string_literal: true

RSpec.describe Tyrion do
  it "has a version number" do
    expect(Tyrion::VERSION).not_to be nil
  end

  it "does something useful" do
    expected_value = true
    expect(expected_value).to eq(true)
  end
end
