({
	handleClick : function(component, event, helper) {
        console.log(component.find("date").get("v.value"));
		helper.sendMessage(component, event);
	},  
	handleWhatsapp : function(component, event, helper) {
       		helper.sendWhatsapp(component, event);
	},
    handlefetch : function(component, event, helper) {
        console.log('handle fetch');
       		helper.fetchmsg(component, event);
	}
})