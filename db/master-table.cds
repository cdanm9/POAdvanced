context com.sap.Master{
  entity Plants{
    key code: String(20);     
    name: String(100);
    city: String(100);   
  }

  entity Companies{
    key code : String(20);
    desc: String(500);
    website: String(500);
    name: String(500);
  }

  entity Materials{
    key code: String(20);
    desc: String(500);
    plantCode: String(20);
    price:Double default 0.0;
    image:String @UI : {IsImageURL : true};    
    to_Plants: Association to Plants on to_Plants.code=plantCode;  
    phone: String(20) @Communication.IsPhoneNumber;
    fax:String(20);
    email      : String(240) @Communication.IsEmailAddress; 
    landline: String(20);                
  }

  entity Statuses{
    key code: Integer;
    desc: String(500);
  }

  entity Users{
    key id: String(20);
    name: String(100);  
  }

}