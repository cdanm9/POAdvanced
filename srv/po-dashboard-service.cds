using com.sap.Transaction as Transaction from '../db/transaction-table';
using com.sap.Master as Master from '../db/master-table';


service PODashboardService@(requires:['authenticated-user']){
     @restrict:[{grant:'READ',to:'ZPO_ADMIN'}]
     entity POHeaders as projection on Transaction.POHeaders;     
     entity POItems as projection on Transaction.POItems;
     entity Plants as projection on Master.Plants;
     entity Companies as projection on Master.Companies;
     entity Materials as projection on Master.Materials;  
     entity Statuses as projection on Master.Statuses; 
     // entity POAttachments as projection on Transaction.POAttachments;           
   
} 