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

  

}