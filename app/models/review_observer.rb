class ReviewObserver < ActiveRecord::Observer

  def after_destroy(review)
    update_data(review)
  end


  def after_save(review)
    update_data(review)
  end

  private

  def update_data(review)
    liveBusiness = Business.find(review.business_id)
    rating_count = liveBusiness.reviews_count

    rating_total =  0
    price_range_total = 0
    price_range_count = 0
    liveBusiness.reviews.each do |rev|
      rating_total += rev.rating
      if rev.price_range > 0
        price_range_total += rev.price_range
        price_range_count += 1
      end
    end

    rating_avg = rating_count > 0 ? rating_total / (rating_count.to_f) : 0

    price_range_avg = if price_range_count > 0
        new_price = (price_range_total / price_range_count).round
        new_price == 0 ? 1 : new_price
      else
        0
      end

    liveBusiness.update_attributes(price_range_avg: price_range_avg, rating_avg: rating_avg)
  end

end
