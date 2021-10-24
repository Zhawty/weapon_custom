$("body").hide() 
$("#attach").hide() 
$("#guns").css("background","#232530")
$("#attachs").css("background","transparent")
var CategorySelect = "guns"
window.addEventListener('message', function(event) {
    switch (event.data.action) {
        case "show":
            $("body").fadeIn(500)    
            $("#guns").css("background","#232530")
            $("#attachs").css("background","transparent")
        break
        case "close":
            $("body").fadeOut(500)    
        break
    }
});

function CloseAll() {
    $("body").fadeOut(500)
    $.post("https://weapon_custom/CloseUi")
}

function ChangeModal(type) {
    switch (type) {
        case "guns":
            $("#guns").css("background","#232530")
            $("#attachs").css("background","transparent")
            CategorySelect = type
            $("#attach").hide() 
            $("#gun").show()
        break
        case "attachs":
            $("#attachs").css("background","#232530")
            $("#guns").css("background","transparent")
            CategorySelect = type
            $("#gun").hide()
            $("#attach").show() 
        break
    }
}

function UpdatePreview() {
    switch (CategorySelect) {
        case "guns": 
            if ( $("#urlg").val() ) {
                $.ajax({
                    url:$("#urlg").val(),
                    type:'HEAD',
                    error: function(){
                        $("#urlg").val('')
                    },
                    success: function(){
                        $("#previewg").attr("src", $("#urlg").val())
                    }
                });
            }
        break
        case "attachs": 
            if ( $("#urla").val() ) {
                $.ajax({
                    url:$("#urla").val(),
                    type:'HEAD',
                    error: function(){
                        $("#urla").val('')
                    },
                    success: function(){
                        $("#previewa").attr("src", $("#urla").val())
                    }
                });
            }
        break
    }
   
}

function ChangeTexture() {
    switch (CategorySelect) {
        case "guns":
            $.post("https://weapon_custom/Farinha",
            JSON.stringify({
                url : $("#urlg").val(),
                type : CategorySelect,
                h : $("#hg").val(),
                w : $("#wg").val()
            }))
        break
        case "attachs": 
            console.log($("#ha").val(),$("#wa").val());
            $.post("https://weapon_custom/Farinha",
            JSON.stringify({
                url : $("#urla").val(),
                type : CategorySelect,
                h : $("#ha").val(),
                w : $("#wa").val()
            }))
        break
    }
    
}

function EquipAttachs() {
    $.post("https://weapon_custom/Sorvete")
}

document.onkeyup = function(data){
    if (data.keyCode == 27){
        CloseAll()
    }
    if (data.keyCode == 13){
        UpdatePreview()
    }
};