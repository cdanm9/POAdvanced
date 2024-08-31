using capm.table as prc from '../db/potables';
using capm.mastertable as masters from '../db/master_tables';

service POCreationService {
     @odata.draft.enabled
     @odata.draft.bypass
     entity POHeader as projection on prc.PO_Header;     
     entity POItem as projection on prc.PO_Item;
     entity PlantMaster as projection on masters.Plant_Master;
     entity CompanyMaster as projection on masters.Company_Master;
     entity POEvent as projection on prc.Event_Log;
     entity Material_Master as projection on masters.Material_Master;  
     entity StatusMaster as projection on masters.Status_Master;
     entity PO_Attachment as projection on prc.PO_Attachment;    
     entity Purchase_Attachment as projection on prc.Purchase_Attachment;   
<<<<<<< HEAD
     entity POExtraHeader as projection on prc.PO_Extra_Header;    

       
     type POFunction:{
          POTest:Boolean;  
     }

     function POReturn(PO_Number:String) returns POFunction;      
=======
     entity POExtraHeader as projection on prc.PO_Extra_Header;        
>>>>>>> 9318e7ab87e3bde0cad583bc9c454f554d515989
}  
