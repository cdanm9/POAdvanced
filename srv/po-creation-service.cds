using com.sap.Transaction as Transaction from '../db/transaction-table';
using com.sap.Master as Master from '../db/master-table';

service POCreationService {

     @Capabilities : {
          FilterRestrictions : {
               FilterExpressionRestrictions :[{
                    Property : 'deliveryDate',
                    AllowedExpressions : 'SingleRange'
               }]
          }
     }
     @odata.draft.enabled
     @odata.draft.bypass
     entity POHeaders as projection on Transaction.POHeaders{
          *
     } actions{   
          action POApprove();   
          action POReject();   
          action POHold();    
     };    

     event POAddEvent{
          poNumber:Integer64;
          status:Integer;
          msg:String(1000); 
     }
     entity POItems as projection on Transaction.POItems;
     entity Plants as projection on Master.Plants;
     entity Companies as projection on Master.Companies;
     entity Materials as projection on Master.Materials;  
     entity Statuses as projection on Master.Statuses; 
     entity POAttachments as projection on Transaction.POAttachments;      
     entity POEvents as projection on Transaction.POEvents;      

}  
