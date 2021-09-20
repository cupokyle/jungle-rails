require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do

  it "is valid with valid attributes" do
    @grocery = Category.new(name: 'Grocery')
    @butter = Product.new(name: 'Butter', price: 5.00, quantity: 32, category: @grocery)
    expect(@butter).to be_valid
  end

  it "is not valid without a name" do
    @grocery = Category.new(name: 'Grocery')

    subject {
      described_class.new(name: nil,
                          price: 5.00,
                          quantity: 50,
                          category: @grocery
                          )
    }
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Name can't be blank")
  end

  it "is not valid without a price" do
    @grocery = Category.new(name: 'Grocery')

    subject {
      described_class.new(name: "Butter",
                          price: nil,
                          quantity: 50,
                          category: @grocery
                          )
    }
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Price can't be blank")
  end

  it "is not valid without a quantity" do
    @grocery = Category.new(name: 'Grocery')

    subject {
      described_class.new(name: "Butter",
                          price: 5.00,
                          quantity: nil,
                          category: @grocery
                          )
    }
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Quantity can't be blank")
  end

  it "is not valid without a category" do

    subject {
      described_class.new(name: "Butter",
                          price: 5.00,
                          quantity: 50,
                          category: nil
                          )
    }
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Category can't be blank")
  end

end
end
