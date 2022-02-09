require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    6.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel#{n+1}.jpg"),
        quantity: 10,
        price: 64.99
      )      
    end
  end
  
  scenario "They add to cart and see cart quantity change to '1'" do
    visit root_path

    nav_cart = page.find('a', text: /My Cart/)
    expect(nav_cart.text).to include 'My Cart (0)'

    page.first('button', text: /Add/).click

    expect(nav_cart.text).to include 'My Cart (1)'
  end
end
