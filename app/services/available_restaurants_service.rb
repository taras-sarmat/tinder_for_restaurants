class AvailableRestaurantsService
  RESTAURANT_SEARCH_PARAMETER = 'restaurants'
  INVALID_PARAMS_ERROR = 'Invalid params'

  def initialize(params)
    @params = params
    @errors = []
    @collection = []
  end

  def perform
    @collection.concat(response_from_yelp.businesses)
    true
  rescue Yelp::Fusion::Error::ValidationError
    @errors << INVALID_PARAMS_ERROR
    false
  end

  attr_reader :params, :errors, :collection

  private

  def response_from_yelp
    Yelp::Fusion.client.search(params[:location], { category_filter: RESTAURANT_SEARCH_PARAMETER, term: params[:term] })
  end
end
