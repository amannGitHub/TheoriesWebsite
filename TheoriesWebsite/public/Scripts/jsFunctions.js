function TxtCntchk(max, txt, cnt) {
  // character count down for textbox control
  //max: maximum characters allowed
  //txt: textbox control clientid
  //cnt: count down label control clientid

  var tb1 = document.getElementById(txt);
  var lb1 = document.getElementById(cnt);
  var len = parseInt(tb1.value.length);

  if (navigator.userAgent.indexOf("Firefox") != -1) {
    //Firefox syntax
    lb1.textContent = max - len;
  } else {
    lb1.innerHTML = max - len;
  }
  if (len > max) {
    alert(max + " Characters allowed");
    return false;
  }
  return true;
}