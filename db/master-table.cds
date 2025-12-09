using {cuid,managed,temporal,sap.common} from '@sap/cds/common';
context com.sap.Master{

  entity Plants{
    key code: String(20);     
    name: String(100);
    city: String(100); 
    to_Companies: Association to Companies; 
    to_Materials: Association to many Materials on to_Materials.plantCode=code;           
  }

  entity Companies{
    key code : String(20);
    desc: String(500);  
    website: String(500);
    name: String(500);
  }

  entity Materials{
    key code: String(20);
    name:String(100);
    desc: String(500);
    plantCode: String(20);   
    price:Double default 0.0;     
    to_Plants: Association to one Plants on to_Plants.code=plantCode;                 
  }

  entity Statuses{
    key code: Integer;
    desc: String(500);
  }

  entity Users{
    key id: String(20);
    firstName: String(100); 
    lastName:String(100);
    loginName:String(50);
    image:String @UI : {IsImageURL : true};  
    imageUri:String;        
    email: String(200) @Communication.IsEmailAddress;  
    phone:String(20)@Communication.IsPhoneNumber;    
  }

  entity Credentials:cuid{
    username:String(300);
    email:String(300);
    password:String(1000);
    type:String(500);
    clientId:String(1000);
    clientSecret:String;
    refToken:String;
    passcode:String(1000);
  }

  entity EmailTemplates{
    key srNo:Integer;
    type:String(50);
    subject:String(200);
    title:String(200);
    content:String;
    remarks:String;
    link:String;
    closing:String;
  }

}