require 'test_helper'

class AvailableRestaurantsController < ActionDispatch::IntegrationTest
  test 'get the list of restaurants without params' do
    get api_v1_available_restaurants_path

    assert_response(422)
  end

  test 'get the list of restaurants with name of the city' do
    get api_v1_available_restaurants_path, params: { location: 'San Francisco' }

    assert_equal 20, json_response.count
    assert_equal 'San Francisco', json_response.dig(0, 'location', 'city')
  end

  test 'get the list of restaurants with name of the city and search term' do
    get api_v1_available_restaurants_path, params: { location: 'San Francisco', term: 'Coffee' }

    assert_equal 20, json_response.count
    assert_equal 'San Francisco', json_response.dig(0, 'location', 'city')
    assert_equal 'The Mill', json_response.dig(0, 'name')
    assert_equal matching_categoris_for_coffee_term, json_response.dig(0, 'categories')
  end

  test 'get the list of restaurants by zip code' do
    get api_v1_available_restaurants_path, params: { location: '94102' }

    assert_equal 20, json_response.count
    assert_equal '94102', json_response.dig(0, 'location', 'zip_code')
  end

  private

  def json_response
    JSON.parse @response.body
  end

  def matching_categoris_for_coffee_term
    [{"alias"=>"coffee", "title"=>"Coffee & Tea"}, {"alias"=>"bakeries", "title"=>"Bakeries"}, {"alias"=>"desserts", "title"=>"Desserts"}]
  end
end
