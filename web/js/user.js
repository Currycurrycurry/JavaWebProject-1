function safe() {
    account1();pass1();pass2();name1();email();code1();
    if(account1()&&pass1()&&pass2()&&name1()&&code1()&&email()){
        var form = document.getElementById('form');
        form.submit();
    } else {
        document.getElementById('safe').innerHTML="请确认信息非空！";
    }
}

function account1(){
    var account = document.getElementById('account').value;
    if(account.length>15){
        document.getElementById('tic1').innerHTML="账号不能超过15位";
        return false;
    } else if(account.length<4){
        document.getElementById('tic1').innerHTML="账号不能小于4位";
        return false;
    } else {
        document.getElementById('tic1').innerHTML="";
        return true;
    }
}

function pass1() {
    var pass1 = document.getElementById('password').value;
    if(pass1.length<6||pass1.length>10){
        document.getElementById('tic2').innerHTML="密码在6-10位之间";
        return false;
    } else {
        document.getElementById('tic2').innerHTML="";
        return true;
    }
}

function pass2() {
    var pass1 = document.getElementById('password').value;
    var pass2 = document.getElementById('password_again').value;
    if(pass2==pass1){
        document.getElementById('tic3').innerHTML="";
        return true;
    }
    else{
        document.getElementById('tic3').innerHTML="两次密码不相同";
        return false;
    }
}

function name1() {
    var y = document.getElementById('name').value;
    if(y==""){
        document.getElementById('tic4').innerHTML="昵称不能为空";
        return false;
    }
    else {document.getElementById('tic4').innerHTML="";return true;}
}

function email(){
    var t = document.getElementById('email').value;
    var pattern = /^[0-9a-zA-Z_]{2,18}@[0-9a-z]+.com$/;
    if(pattern.test(t)){
        document.getElementById('tic5').innerHTML="";
        return true}
    else{
        document.getElementById('tic5').innerHTML="x(2-18位)@x.com";
        return false;
    }
}

function code1() {
    var code = document.getElementById('code').value;
    return code!="";
}

//修改验证码
function _change() {
    var imgEle = document.getElementById('vCode');
    imgEle.src = "VerifyCodeServlet?"+new Date().getTime();
}
