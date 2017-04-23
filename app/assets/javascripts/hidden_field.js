function firstFunction(score) {
  $('#time').val(score)
}
function secondFunction()  {
  var time = 1000;
  var score = 5;
  for(i = 0; i < 6; i++ ) {
    setTimeout(firstFunction, time, score)
    time = time + 20000;
    score--;
  }
}

secondFunction();
