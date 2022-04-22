public class WhatsappMessagingService {
    
     @Auraenabled
    public static list<string> fetchMessage(string mobileno){
       // msg m=new msg();
      List<string>mess=new List<String>();
        errorResponseWrapper erw;
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+constants_dec.account+'/Messages.json');
        req.setMethod('GET'); 
        //req.setHeader('Content-Type','application/json');
        //req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(constants_dec.account + ':' + constants_dec.token);
        Blob msgsidval=Blob.valueOf(constants_dec.msg_sid);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
        System.debug(res.getStatusCode());
                system.debug(Res.getBody());
                system.debug(res.getStatus());
                if(res.getStatusCode()==200)
                {
                    system.debug('Twilio Success'+mobileno);
                  // m=(msg)json.deserialize(Res.getBody(),msg.class);
                   // system.Debug(m);
                   Map<String,Object> r=(Map<String,Object>)Json.deserializeUntyped(res.getBody());
                    List<object> b=(List<object>)r.get('messages');
                    for(object obj1:b){
                                Map<String,Object>b1=(Map<String,Object>) obj1;
                           String s=(string)b1.get('body');
                        String ph=(String)b1.get('to');
                    if((mess.size()<20)&&(ph==mobileno))
                              mess.add(s);
                            }
                  System.debug(mess.size());
                }
                else{
                    system.debug('Twilio failed'+mobileno);
                    erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
                    system.debug('Twilio error'+erw.message);
                }
            }
            catch(Exception e){
                system.debug('Error :'+e);
            } 
            return mess;
        }
    
    @Auraenabled
    public static void scheduleMessage(string mobileno,string message,Integer year,Integer mon,Integer day){
        errorResponseWrapper erw;
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+constants_dec.account+'/Messages.json');
        req.setMethod('POST'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(constants_dec.account + ':' + constants_dec.token);
        Blob msgsidval=Blob.valueOf(constants_dec.msg_sid);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        
        if(mobileno != null)
        {
            //String dt=year+'-'+mon+'-'+day;
            //system.debug(dt);
            string jsonString='MessagingServiceSid='+EncodingUtil.urlEncode(constants_dec.msg_sid, 'UTF-8')+'&Body='+EncodingUtil.urlEncode(message, 'UTF-8')+'&sendAt='+datetime.newInstancegmt(year, mon, day,02,20,50)+'&scheduleType='+EncodingUtil.urlEncode('fixed', 'UTF-8')+'&To='+EncodingUtil.urlEncode(mobileno+'', 'UTF-8')+'';
            req.setBody(jsonString);
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug(res.getBody());
                system.debug(res.getStatus());
                if(res.getStatusCode()==201)
                    system.debug('Twilio Success'+mobileno);
                else{
                    system.debug('Twilio failed'+mobileno);
                    erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
                    system.debug('Twilio error'+erw.message);
                }
            }
            catch(Exception e){
                system.debug('Error :'+e);
            } 
            
        }
    }
    @AuraEnabled
    public static void sendMessage(string mobileno,string message)
    {
        errorResponseWrapper erw;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+constants_dec.account+'/Messages.json');
        req.setMethod('POST'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(constants_dec.account + ':' + constants_dec.token);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        
        if(mobileno != null)
        {
            string jsonString='From='+EncodingUtil.urlEncode('whatsapp:'+constants_dec.fromNumber+'', 'UTF-8')+'&Body='+EncodingUtil.urlEncode(message, 'UTF-8')+'&To='+EncodingUtil.urlEncode('whatsapp:'+mobileno+'', 'UTF-8')+'';
            req.setBody(jsonString);
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug(res.getBody());
                if(res.getStatusCode()==201)
                    system.debug('Twilio Success'+mobileno);
                else{
                    system.debug('Twilio failed'+mobileno);
                    erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
                    system.debug('Twilio error'+erw.message);
                }
            }
            catch(Exception e){
                system.debug('Error :'+e);
            } 
            
        }
    }
    public class errorResponseWrapper{
        String code;
        String message;
        String moreInfo;
        String status;    
    }
    
}