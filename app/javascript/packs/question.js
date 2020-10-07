$(function(){
    $("#question_similar_form").hide();
    $("#question_similar_qlus").click(function(){
      $("#question_similar_form").slideToggle("slow");
      var test = $("#question_similar_qlus").html();
      if (test == '類義語を追加+') {
          $("#question_similar_qlus").html('フォームを閉じる')
      } else if (test == 'フォームを閉じる') {
          $("#question_similar_qlus").html('類義語を追加+')
      }
    });
  });
