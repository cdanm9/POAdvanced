const cds=require("@sap/cds")
module.exports=cds.service.impl(function(srv){
    const { POHeaders, POItems,POAttachments} = this.entities;   
    this.before('NEW', POHeaders.draft, async req => {
        let aPONumber;
        try{
            if(req.path==req.entity){       
                aPONumber= await SELECT .from(POHeaders.drafts,['Max(poNumber) as poNumber']);
                req.data.poNumber=!(aPONumber[0].poNumber)?10001:(Number(aPONumber[0].poNumber)+1);   
                req.data.status=5;          
            }else{   
                   
            }
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
    })

    this.before('NEW',POAttachments,async req => { 
    })

    this.on ('error', async (err, req) => {         
    })
});
