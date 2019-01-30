require 'rails_helper'

describe Book, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:author)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:published)}
  end
end
