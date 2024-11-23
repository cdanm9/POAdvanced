using {cuid,managed,temporal,sap.common} from '@sap/cds/common';
using com.sap.Master as Master from './master-table'; 
context com.sap.Transaction{
     
  entity POHeaders: managed,cuid{
    // poNumber: Integer64 not null; 
    poNumber: Integer64; 
    deliveryDate: Date;
    status: Integer; 
    @Search.fuzzinessThreshold: 0.7   
    madeBy: managed:createdBy;           
    remarks:String;
    plantCode: String(20); 
    companyCode: String(20); 
    criticality: Integer default 0;    
    totalAmount: Decimal default 0;          
    to_Plants: Association to Master.Plants;
    to_Companies: Association to Master.Companies;    
    to_Statuses: Association to Master.Statuses;                                            
    to_POItems: Composition of many POItems on to_POItems.to_POHeaders=$self;                       
    // to_POAttachments: Composition of many POAttachments on to_POAttachments.to_POHeaders=$self;     
  };              

  entity POItems: cuid{         
    // key POI_Unique: UUID;
    // poNumber: Integer64 not null;
    poNumber: Integer64;   
    // poItemNo:Integer not null;   
    poItemNo:Integer; 
    materialCode: String(20);    
    quantity: Integer @assert.range:[1,100];          
    amount: Decimal; 
    to_Materials: Association to Master.Materials;         
    to_POHeaders: Association to POHeaders;    
  }     

  // entity POAttachments: cuid,managed{
  //   poNumber: Integer64; 
  //   @Core.IsMediaType: true mimeType:String;
  //   @Core.MediaType:mimeType content:LargeBinary @Core.ContentDisposition.Filename: name;    
  //   name: String;
  //   to_POHeaders: Association to POHeaders; 
  //   url:String;    
  // }
      
}


