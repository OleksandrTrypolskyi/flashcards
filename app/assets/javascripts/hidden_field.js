function firstFunction() {
    $('#time').val(5);
}

function secondFunction() {
    $('#time').val(4);
}

function thirdFunction() {
    $('#time').val(3);
}

function fourthFunction() {
    $('#time').val(2);
}

function fifthFunction() {
    $('#time').val(1);
}

function sixthFunction() {
    $('#time').val(0);
}

function oneFunc() {
  setTimeout(firstFunction, 1000);
  setTimeout(secondFunction, 20000);
  setTimeout(thirdFunction, 60000);
  setTimeout(fourthFunction, 90000);
  setTimeout(fifthFunction, 120000);
  setTimeout(sixthFunction, 180000);
}

oneFunc();
