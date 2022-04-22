({
    sendMessage : function(component, event) {
        var isSigned = false;
        console.log('working');
        var dt=component.find("date").get("v.value");
        var splitdt=dt.split('-');
        var action = component.get("c.scheduleMessage");
        action.setParams({
            mobileno: component.find("mobileNumber").get("v.value"),
            message: component.find("message").get("v.value"),
            year:splitdt[0],
            mon:splitdt[1],
            day:splitdt[2]
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "Message Sent"
                });
                toastEvent.fire();
            } else {
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "title": "Something has gone wrong!",
                    "message": "Unfortunately, there was a problem while sending Message"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
   sendWhatsapp : function(component, event) {
        var action = component.get("c.sendMessage");
        action.setParams({
            mobileno: component.find("mobileNumber1").get("v.value"),
            message: component.find("message1").get("v.value")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEve=$A.get("e.force:showToast");
                toastEve.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "Message Sent"
                });
                toastEve.fire();
            } else {
                var toastEve=$A.get("e.force:showToast");
                toastEve.setParams({
                    "type": "error",
                    "title": "Something has gone wrong!",
                    "message": "Unfortunately, there was a problem while sending Message"
                });
                toastEve.fire();
            }
        });
        $A.enqueueAction(action);
    },
    fetchmsg : function(component, event) {
        var isSigned = false;
        console.log('working');
        var action = component.get("c.fetchMessage");
        action.setParams({
            mobileno: component.find("mobileNumber2").get("v.value"),
        });
        action.setCallback(this, function(response) {
            console.log(response.getState());
            console.log(response.getReturnValue());
            var state = response.getState();  
            
            if (state === "SUCCESS") {
                   component.set('v.msgs',response.getReturnValue());
                console.log(response.getState());
                console.log(component.get('v.msgs').length);
                console.log(response.getReturnValue());
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "Messages Fetched!"
                });
                toastEvent.fire();
            } else {
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "title": "Something has gone wrong!",
                    "message": "Unfortunately, there was a problem while sending Message"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
        var spin=component.find('condnShow');
        $A.util.removeClass(spin,"slds-hide");
    }
})