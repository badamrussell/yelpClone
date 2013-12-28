//----- POPUPS

var closePopup = function() {
  var $pop = $(".popup-show");

  if ($pop) { $pop.removeClass("popup-show") }
  if ($pop) { $pop.addClass("popup-hide") }
  console.log("CLOSE", $pop);
}

var showPopup = function(popupName, id) {
  closePopup();

  var $pop = $(popupName);
  console.log("OPEN", $pop, popupName, id);
  if ($pop) {
    $pop.addClass("popup-show");
    var $a = $pop.find(".main-id")
    $a.attr("value", id)

    //$pop.
  }
  console.log("OPEN", $pop, popupName);
}

// var showCategoryPopup = function() {
//   closePopup();
//
//   var $pop = $("#category-popup");
//
//   if ($pop) {
//     $pop.addClass("popup-show");
//     var $a = $pop.find(".main-id")
//
//     //update visible fields
//     var ch = $("#category-selections input:checked");
//     for(var i=0; i < ch.length; i++) {
//
//       $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
//     }
//     //update hidden fields
//     var ch = $("#category-selections :input[type='hidden']")
//     for(var i=0; i < ch.length; i++) {
//
//       $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
//     }
//     //$pop.
//   }
// }

// var showFeaturePopup = function() {
//   closePopup();
//
//   var $pop = $("#feature-popup");
//
//   if ($pop) {
//     $pop.addClass("popup-show");
//     var $a = $pop.find(".main-id")
//
//     //update visible fields
//     var ch = $("#feature-selections input:checked");
//     for(var i=0; i < ch.length; i++) {
//
//       $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
//     }
//     //update hidden fields
//     var ch = $("#feature-selections :input[type='hidden']")
//     for(var i=0; i < ch.length; i++) {
//
//       $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
//     }
//     //$pop.
//   }
// }

var showFilterPopup = function(mainEl, choiceCont) {
  closePopup();

  var $pop = $(mainEl);

  if ($pop) {
    $pop.addClass("popup-show");
    var $a = $pop.find(".main-id")

    //update visible fields
    var ch = $(choiceCont + " input:checked");
    for(var i=0; i < ch.length; i++) {

      $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
    }

    //update hidden fields
    ch = $(choiceCont + " :input[type='hidden']")
    for(var i=0; i < ch.length; i++) {

      $(".choice :input[value='" + $(ch[i]).attr("value") + "']").prop("checked",  true)
    }
    //$pop.
  }
}

var submitPopupSearch = function(formEl, mainEl) {
  var choices = $(formEl + " .popup-form-container").serializeArray()

  var $main = $(mainEl);
  $(mainEl + " li").remove();

  for (var i=0; i < choices.length; i++) {
    var $li = $("<li></li>");
    $main.append($li);
    if (i < 5) {
      $("<input>").attr({
        type: "checkbox",
        name: choices[i].name,
        value: choices[i].value,
        checked: true
      }).appendTo($li);
    } else {
      $("<input>").attr({
        type: "hidden",
        name: choices[i].name,
        value: choices[i].value
      }).appendTo($li);
    }
  }

  closePopup();
  $("#fine-search-submit").trigger("click")
}