var makeReviewElement = function(business, size, biz_url, cat_url) {
  var $mainEl = $('<div class="business-result group"></div>');
  $mainEl.prop("data-lat",business.latitude);
  $mainEl.prop("data-lng",business.longitude);

  var biz_rating = '<div class="star-' + size + '-' + business.rating_string + '"></div>';

  var biz_price = "";
  for (var i=0; i < business.price_range; i++) {
    biz_price += "$";
  }

  var biz_categories = "";
  var biz_stats = "";
  var biz_address = "";
  var content = "";

  for (var i=0; i < business.categories.length; i++) {
    var category = business.categories[i];
    biz_categories += '<span class="med-link"><a href="' + cat_url + category.id + '">' + category.name + '</a></span>';
  }

  biz_stats = '<div class="business-info"> \
      <div class="business-header"> \
          <h1 class="page-title"><a href="' + biz_url + business.id + '">' + business.name + '</a></h1> \
      </div> \
      <div class="rating-container group"> \
        <div class="rating-container group left">' + biz_rating + '</div> \
        <em class="">' + business.reviews_count + 'reviews</em> \
      </div> \
      <div class="category-container"><div class="price-range-container left">' + biz_price + '</div>' + biz_categories + '</div></div>';

  if (business.neighborhood.name) {
     biz_address += '<p class="biz-neighborhood">' + business.neighborhood.name + '</p>'
  }
  if (business.address1) {
    biz_address += '<p>' + business.address1 + '</p>'
  }
  if (business.address2) {
    biz_address += '<p>' + business.address2 + '</p>'
  }
  if (business.city) {
    biz_address += '<p>' + business.city + ', ' + business.state + ' ' + business.zip_code + '</p>'
  }
  if (business.phone_number) {
    biz_address += '<p>' + business.phone_number + '</p>'
  }


  content = '<section class="business-info-container group"> \
    <img class="avatar-90" width="100" src="' + business.avatar + '"> \
    <div class="business-stats">' + biz_stats + '</div> \
    <div class="business-address"> \
      <address>' + biz_address + '</address> \
    </div> \
  </section>';


  $mainEl.html(content);

  return $mainEl;
}


