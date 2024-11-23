using com.sap.Transaction as Transaction from '../db/transaction-table';
using com.sap.Master as Master from '../db/master-table';

service POBaseService {  
     entity POHeader as projection on Transaction.POHeaders;   
     entity POItem as projection on Transaction.POItems;
     entity PlantMaster as projection on Master.Plants;
     entity CompanyMaster as projection on Master.Companies;
     entity Material_Master as projection on Master.Materials;           
     entity StatusMaster as projection on Master.Statuses; 
     // entity POAttachments as projection on Transaction.POAttachments;  
} 
