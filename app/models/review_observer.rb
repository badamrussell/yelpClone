class ReviewObserver < ActiveRecord::Observer

  def before_destroy(review)
    review.business_features.each { |bf| bf.destroy }
  end

  def after_create(review)
    update_data(review, 1)
  end

  def after_destroy(review)
    update_data(review, -1)
  end

  def after_update(review)
    update_data(review, 0)
  end


  private

  def update_data(review, increment)
    review.instance_eval do
      rating_total =  0
      rating_count = business.reviews_count + increment
      price_range_total = 0
      price_range_count = increment

      business.reviews.each do |rev|
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

      business.update_attributes(price_range_avg: price_range_avg, rating_avg: rating_avg)
    end
  end

end
