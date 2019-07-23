var ajax;

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

function getAjax() {
    try {
        ajax = new XMLHttpRequest();
    } catch (e) {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return ajax;
}

function jump() {
    ajax = getAjax();
    ajax.open("POST", "/sign", true);
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200) {
            var result = ajax.responseText;
            if (result == "success") {
                document.getElementById("tic1").innerHTML = "";
                document.getElementById("tic6").innerHTML = "";
                alert("注册成功！点击返回主页");
                location.href = "/index.jsp";
            } else if(result=="exist") {
                document.getElementById("tic1").innerHTML = "用户名已存在！";
            } else if(result=="vCode"){
                document.getElementById("tic6").innerHTML = "验证码错误！";
            }
        }
    };
    ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    var account = document.getElementById('account').value;
    var password = document.getElementById('password').value;
    var email = document.getElementById('email').value;
    var name = document.getElementById('name').value;
    var code = document.getElementById('code').value;
    var param = "account="+account+"&password="+password+"&name="+name+"&email="+email+"&code="+code;
    ajax.send(param);
}

var bt = document.getElementById("safeInput");
bt.onclick = function() {
    account1();pass1();pass2();name1();email();code1();
    if(account1()&&pass1()&&pass2()&&name1()&&code1()&&email()){
        document.getElementById('safe').innerHTML="";
        jump();
    } else {
        document.getElementById('safe').innerHTML="请确认信息非空！";
    }
};
