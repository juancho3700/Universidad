function checkAll (element) {

    checkbox = document.getElementsByName ('cgenre[]');

    for (var i = 0; i < checkbox.length; i++) {

        checkbox [i].checked = element.checked;
    }
}

function method_GET () {

    document.getElementById ("cencoding_app").checked = true;
    document.getElementById ("cencoding_multi").disabled = true;
}


function method_POST () {

    document.getElementById ("cencoding_multi").disabled = false;
}


function consulta_usuario (clogin_value) {

    const test_clogin = new RegExp ("([a-z0-9]){4,8}");
    document.getElementById ("submit_button").disabled = false;

    if (clogin_value && !test_clogin.test (clogin_value)) {

        document.getElementById ("submit_button").disabled = true;
        alert ("El usuario no cumple los requisitos. Solo se podrán usar letras ASCII minúsculas y números y debe tener una longitud de entre 4 y 8 caracteres");
        return;
    }

    return true;
}


function consulta_password (cpasswd_value) {

    const test_cpasswd = new RegExp ("(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\+-\/*]).{6,12}");
    document.getElementById ("submit_button").disabled = false;

    if (cpasswd_value && !test_cpasswd.test (cpasswd_value)) {

        document.getElementById ("submit_button").disabled = true;
        alert ("La contraseña no cumple los requisitos. Debe contener una letra mayúscula, una minúscula, un número y un caracter de los siguientes: + - / *. Además, solo se podrán usar los caracteres anteriores y debe tener longitud entre 6 y 12 caracteres");
        return;
    }

    return true;
}


function consulta_dni (cdni_value) {

    const test_cdni = new RegExp ("[0-9]{8}[a-zA-Z]{1}$");
    document.getElementById ("submit_button").disabled = false;

    if (cdni_value && !test_cdni.test (cdni_value)) {

        document.getElementById ("submit_button").disabled = true;
        alert ("El DNI no cumple los requisitos. Debe estar formado por 8 dígitos y 1 letra en ese orden");
        return;
    }

    return true;
}


function enviarForms (form) {

    var browser = navigator.userAgent;
    document.getElementById ("cbrowser").value = browser;

    var date = new Date ();
    document.getElementById ("cdate").value = date;

    form.enctype = "application/x-www-form-urlencoded";

    if (document.getElementById ("cmethod_get").checked) {

        form.method = "GET";

    } else if (document.getElementById ("cmethod_post").checked) {

        form.method = "POST";

        if (document.getElementById ("cencoding_multi").checked) {

            form.enctype = "multipart/form-data";
        }
    }

    return true;
}
