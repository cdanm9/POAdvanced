const cds=require("@sap/cds")
const library=require("./Library/responseHandle");
const { uuid } = require("@sap/cds/lib/utils/cds-utils");
const dbClass = require("sap-hdbext-promisfied")
const hdbext = require("@sap/hdbext")
module.exports=cds.service.impl(function(srv){
    const { POHeader, POItem,PO_Attachment,Purchase_Attachment,POEvent } = this.entities;   
    var iPurchaseNum;
<<<<<<< HEAD
=======


>>>>>>> 9318e7ab87e3bde0cad583bc9c454f554d515989

    this.before('NEW', POHeader, async req => {
        try{
            
            let iPONumber;
            let aPO_Number= await SELECT .from('CAPM_TABLE_PO_HEADER',['Max(PO_Number) as PO_Number']); 
            if(aPO_Number[0].PO_Number==null){
                req.data.PO_Number=10001; 
            }else{
                req.data.PO_Number=Number(aPO_Number[0].PO_Number)+1;
            }
            iPurchaseNum=req.data.PO_Number;
            req.data.Status=1;
            req.data.Criticality=0;   
            req.data.CreationDate=new Date().toISOString().split('T')[0];   

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE', POHeader, async req => {
        try{
            var sMessage;
            if(iPurchaseNum){
                req.data.PO_Number=iPurchaseNum;
            }
            var aPOItem=req.data.PO_Item_Master;
            var nAmount=0;
            var iLength=aPOItem.length;
            for(var i in aPOItem){
                aPOItem[i].PO_Item_Num=iLength;        
                var aMaterialMaster=await SELECT .from('CAPM_MASTERTABLE_MATERIAL_MASTER') .where({CODE:aPOItem[i].MCode});
                aPOItem[i].Amount=aPOItem[i].Quantity*aMaterialMaster[0].PRICE
                nAmount=nAmount+aPOItem[i].Amount;
                iLength=iLength-1;           
            }
            req.data.Total_Amount=nAmount;
            var oPOEvent={   
                PO_Number:req.data.PO_Number,
                EVENT_CODE:1,
                EVENT_DESCRIPTION:'Purchase Order Created',
                EVENT_DATE:new Date().toISOString(),   
                EVENT_BY:'CDAN'  
            }   
            var aPOEvent=[];
            
            aPOEvent.push(oPOEvent);
            // await srv.send('POST','/POEvent',aPOEvent)            
            var qQueryInsertEvent=await INSERT(aPOEvent).into('CAPM_TABLE_EVENT_LOG');
            sMessage=`PO Number : ${aPOEvent[0].PO_Number} Created Successfully!`;
            await library.handleResponse(req,'success',200,sMessage)           
               

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
        
    });

    this.before('SAVE', POHeader, async req => {
        try{
            // req.data.PO_Number=iPurchaseNum;
            

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
        
    })
        
    this.before('NEW', POItem, async req => {
         
        try{
        
            req.data.PO_Number=iPurchaseNum;
            const { PO_Header_Master_ID } = req.data
            const { maxPOItem } = await SELECT.one `max(PO_Item_Num) as maxPOItem` .from (POItem.drafts) .where ({PO_Header_Master_ID})
            req.data.PO_Item_Num = maxPOItem + 1;              

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE', POItem, async req => {
        try{
            req.data.PO_Number=iPurchaseNum;
            
        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })
    
    this.after('READ',POHeader,async req=>{
        try{
            // var oData=req.data
        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.after('READ',POItem,async req=>{
        try{

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('SAVE', POItem, async req => {
        try{
            req.data.PO_Number=iPurchaseNum;   

        }catch(oError){     
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE',Purchase_Attachment,async req => {
        console.log('Create called')
        console.log(JSON.stringify(req.data))
        req.data.PO_Number=iPurchaseNum;      
        req.data.url = `/pocreation/Purchase_Attachment(${req.data.ID})/content`  
    })

    this.before('NEW',PO_Attachment,async req => {   
        req.data.PO_Number =iPurchaseNum;      
    })

    this.before('CREATE',PO_Attachment,async req => {   
        req.data.FileURL = `/pocreation/PO_Attachment(${req.data.ID})/File`   
    })

    //Error handler    
    this.on ('error', async (err, req) => {   
        var sMessage = 'Oh no! ' + err.message;        
    })
    
          
});
