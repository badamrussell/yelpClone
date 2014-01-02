//----- POPUPS

var closePopup = function() {
  var $pop = $(".popup-show");

  if ($pop) { $pop.removeClass("popup-show") }
  if ($pop) { $pop.addClass("popup-hide") }

  $("#overlay").addClass("hidden");
  $("body").removeClass();

  console.log("CLOSE", $pop);
}

var showPopup = function(popupName, id) {
  closePopup();


  var $pop = $(popupName);
  console.log("OPEN", $pop, popupName, id);
  if ($pop) {
    $("#overlay").removeClass();
    $("body").addClass("no-scroll");
    $pop.addClass("popup-show");

    var $a = $pop.find(".main-id")
    $a.attr("value", id)
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

    $("#overlay").removeClass();
    $("body").addClass("no-scroll");

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

var makeEl_li = function($divEl) {
  var $li = $("<li></li>");

  var $input = $divEl.find("input").clone();
  var $label = $divEl.find("label").clone();
  $input.removeClass();

  $li.append($input);
  $li.append($label);

  return $li;
}

var submitPopupSearch = function(formEl, mainEl) {
  var $main = $(mainEl);
  var $choices = $(formEl).find(".choices-container");
  var checked = $choices.find("input:checked").parent();
  var first5 = Array.prototype.slice.call($choices.find("input:not(:checked)").parent().slice(0,5));

  $(mainEl + " li").remove();

  for (var i=0; i < checked.length; i++) {
    if (i < 5) {
      var $li = makeEl_li($(checked[i]));
      // $li.find("input").prop("checked",true);
      $main.append($li);

      first5.pop();
    } else {
      var $li = $("<li></li>");
      var $input = $(checked[i]).find("input");

      $("<input>").attr({
        type: "hidden",
        name: $input.attr("name"),
        value: $input.attr("value")
      }).appendTo($li);
    }
  }

  for (var i=0; i < first5.length; i++) {
    var $li = makeEl_li($(first5[i]));
    $main.append($li);
  }

  closePopup();
  document.getElementById("form-fine-filters").submit();
}
