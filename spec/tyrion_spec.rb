# frozen_string_literal: true

RSpec.describe Tyrion do
  it "doit avoir une version défini" do
    expect(Tyrion::VERSION).not_to be nil
  end
end
