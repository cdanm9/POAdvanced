const cds=require("@sap/cds")
module.exports=cds.service.impl(function(srv){
    const { POHeaders, POItems,POAttachments} = this.entities; 
    
       
    this.before('NEW', POHeaders.draft, async req => {
        try{
            let {entity,path,target}=req,aPONumber;
            if(entity==target){
                aPONumber= await SELECT .from(POHeaders,['Max(poNumber) as poNumber']);       
                req.data.poNumber=(!aPONumber[0]?.poNumber)?10001:(Number(aPONumber[0].poNumber)+1)
                req.data.status=5        
            }    
               
        }catch(oError){
            req.error(oError)
        }
    })

    this.before('NEW', POHeaders, async req => {
        try{ 
            let aPONumber= await SELECT .from(POHeaders,['Max(poNumber) as poNumber']);       
            req.data.poNumber=(!aPONumber[0]?.poNumber)?10001:(Number(aPONumber[0].poNumber)+1)
            req.data.status=5     
               
        }catch(oError){
            req.error(oError)
        }
    })

    this.before('CREATE', POHeaders, async req => {
        try{

        }catch(oError){
            req.error(oError)
        }
        
    });

    this.before('SAVE', POHeaders, async req => {   
        try{
            const {deliveryDate,remarks, plantCode, companyCode,to_POItems,to_POAttachments} = req.data;    
            if (!deliveryDate) req.error(400, "Please Enter Delivery Date", "in/deliveryDate")
            if (!remarks) req.error(400, "Please Enter Remarks", "in/remarks")
            if (!plantCode) req.error(400, "Please Enter Plant", "in/plantCode")   
            if (!companyCode) req.error(400, "Please Enter Company", "in/companyCode")      
        
            for (const POItems of to_POItems) {
                const {poItemNo, materialCode, quantity, amount, to_POItems_ID} = POItems
                if (!poItemNo) req.error(400, "Please Enter PO Item Number", `in/to_POItems(ID='${to_POItems_ID}',IsActiveEntity=false)/poItemNo`)
                if (!quantity) req.error(400, "Please Enter Quantity", `in/to_POItems(ID='${to_POItems_ID}',IsActiveEntity=false)/quantity`)
                if (!amount) req.error(400, "Please Enter Amount", `in/to_POItems(ID='${to_POItems_ID}',IsActiveEntity=false)/amount`)         
                if (!materialCode) req.error(400, "Please Enter Material Code", `in/to_POItems(ID='${to_POItems_ID}',IsActiveEntity=false)/materialCode`)   
            }         

            for (const POAttachments of to_POAttachments) {
                const {mimeType, content, name, to_POAttachments_ID} = POAttachments
                if (!mimeType) req.error(400, "Please Enter Mime Type", `in/to_POAttachments(ID='${to_POAttachments_ID}',IsActiveEntity=false)/mimeType`)
                if (!content) req.error(400, "Please Enter File Content", `in/to_POAttachments(ID='${to_POAttachments_ID}',IsActiveEntity=false)/content`)
                if (!name) req.error(400, "Please Enter File Name", `in/to_POAttachments(ID='${to_POAttachments_ID}',IsActiveEntity=false)/name`)         
            }

        }catch(oError){    
            req.error(oError)
        }
        
    })
        
    this.before('NEW', POItems, async req => {
        try{

        }catch(oError){
            req.error(oError)
        }
    })

    this.before('CREATE', POItems, async req => {
        try{

        }catch(oError){
            req.error(oError)
        }
    })
    
    this.after('READ',POHeaders,async req=>{
        try{

        }catch(oError){
            req.error(oError)
        }
    })

    this.after('READ',POItems,async req=>{
        try{

        }catch(oError){
            req.error(oError)
        }
    })

    this.before('SAVE', POItems, async req => {
        try{ 

        }catch(oError){     
            req.error(oError)
        }
    })

    this.before('CREATE',POAttachments,async req => { 
        try{ 

        }catch(oError){     
            req.error(oError)
        }
    })

    this.before('NEW',POAttachments,async req => { 
        try{ 

        }catch(oError){     
            req.error(oError)
        }
    })

    this.before('CREATE',POAttachments,async req => {  
        try{ 

        }catch(oError){     
            req.error(oError)
        } 
    })

    this.on ('error', async (err, req) => {         
    })
});
