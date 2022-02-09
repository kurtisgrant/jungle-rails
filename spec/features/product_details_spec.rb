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
  
  scenario "They click a product and see product details" do
    visit root_path

    page.first('img').click

    expect(page).to have_css('article.product-detail')
  end
end
