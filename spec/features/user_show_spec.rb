require 'rails_helper'

RSpec.describe 'when visitor visits user show page', type: :feature do

  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @book_1 = create(:book)
    @book_2 = create(:book)
    @book_3 = create(:book)
    @review_1 = create(:review, user_id: @user_1.id, book_id: @book_1.id)
    @review_2 = create(:review, user_id: @user_1.id, book_id: @book_2.id, created_at: 2019-03-05)
    @review_3 = create(:review, user_id: @user_2.id, book_id: @book_3.id, created_at: 2019-04-05)
  end

  it 'sees a nav bar' do

    visit user_path(@user_1.id)

    expect(page).to have_link("Home")
    expect(page).to have_link("Browse Books")
  end
  it 'goes to the book index page when link is pressed' do

    visit user_path(@user_1.id)

    click_link("Browse Books")

    expect(current_path).to eq(books_path)

  end

  it 'goes to the home book page when link is pressed' do

    visit user_path(@user_1.id)

    click_link("Home")

    expect(current_path).to eq(root_path)

  end

  it 'shows the user and reviews' do

    visit user_path(@user_1.id)

    expect(page).to have_content("#{@user_1.name}")
    expect(page).to have_content("Title: #{@review_1.title}")
    expect(page).to have_content("#{@review_1.review}")
    expect(page).to have_content("Rating: #{@review_1.rating}")
    expect(page).to have_content("Book Title: #{@review_1.book.title}")
    expect(page).to have_css("img[src*='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd3cgsv8lMoNU4g8dDN1hUqKlXAR3DTITUd5rl1tMuYds_wAP6']")
    expect(page).to have_content("Date Reviewed: #{@review_1.created_at.to_date.to_s}")
    expect(page).to have_content("Title: #{@review_2.title}")
    expect(page).to have_no_content("Title: #{@review_3.title}")
  end

  it "link to sort reviews by date newest to oldest" do

    visit user_path(@user_1.id)
    expect(page).to have_link("Newest To Oldest")
    click_link("Newest To Oldest")

    expect(page.all('.single-review')[0]).to have_content("Title: #{@review_1.title}")
    expect(page.all('.single-review')[1]).to have_content("Title: #{@review_2.title}")


    expect(current_path).to eq(user_path(@user_1.id,))
  end
  it "link to sort reviews by date oldest to newest" do

    visit user_path(@user_1.id)

    expect(page).to have_link("Oldest To Newest")
    click_link("Oldest To Newest")

    expect(page.all('.single-review')[0]).to have_content("Title: #{@review_1.title}")
    expect(page.all('.single-review')[1]).to have_content("Title: #{@review_2.title}")


    expect(current_path).to eq(user_path(@user_1.id,))
  end

  it "button to delete single review" do

  visit user_path(@user_1.id)

  within "#review-#{@review_1.id}" do
    expect(page).to have_button("X")
    click_button("X")
  end
  expect(current_path).to eq(user_path(@user_1.id))
  expect(page).to_not have_content("Title: #{@review_1.title}")
  expect(page).to have_content("Title: #{@review_2.title}")
end
end
