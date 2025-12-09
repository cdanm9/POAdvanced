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
     entity POItems as projection on Transaction.POItems;
     entity Plants as projection on Master.Plants;
     entity Companies as projection on Master.Companies;
     entity POAttachments as projection on Transaction.POAttachments;      
     entity POEvents as projection on Transaction.POEvents;   
     entity Credentials 
     @(restrict: [
          { grant: '*', to: 'SuperAdmin'} 
     ]) 
     as projection on Master.Credentials;    

     entity EmailTemplates as projection on Master.EmailTemplates;     

}  
