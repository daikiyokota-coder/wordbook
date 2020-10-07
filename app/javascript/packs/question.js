$(function(){
    $("#question_similar_form").hide();
    $("#question_similar_qlus").click(function(){
      $("#question_similar_form").slideToggle("slow");
      var similar_form_text = $("#question_similar_qlus").html();
      if (similar_form_text == '類義語を追加+') {
          $("#question_similar_qlus").html('フォームを閉じる')
      } else if (similar_form_text == 'フォームを閉じる') {
          $("#question_similar_qlus").html('類義語を追加+')
      }
    });
  });
