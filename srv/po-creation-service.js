const cds=require("@sap/cds")
// module.exports=cds.service.impl(function(srv){

module.exports= class POCreationService extends cds.ApplicationService { async init() {
    const { POHeaders, POItems,POAttachments} = this.entities;   
    this.before('NEW', POHeaders.drafts, async req => {
        req.data.to_Statuses_code=0;          
    })

    this.before('CREATE', POHeaders, async req => { 
        let { maxPoNumber } = await SELECT.one (`max(poNumber) as maxPoNumber`) .from (POHeaders);
        req.data.poNumber = (maxPoNumber == null) ? 100001 : ++maxPoNumber;
        req.data.to_Statuses_code=5; 
    });

    this.before('SAVE', POHeaders, async req => {
        
    })
        
    this.before('NEW', POItems, async req => {
        let { maxPoItemNo } = await SELECT.one(`max(poItemNo) as maxPoItemNo`).from(POItems.drafts).where(req.data);
        req.data.poItemNo =++maxPoItemNo;
    })

    this.before('CREATE', POItems, async req => {
    })
    
    this.after('READ',POHeaders,async req=>{
    })

    this.after('READ',POItems,async req=>{
    })

    this.before('SAVE', POItems, async req => {
    })

    this.before('CREATE',POAttachments,async req => { 
    })

    this.before('NEW',POAttachments,async req => { 
    })


    this.on ('POApprove',async req => {
        await UPDATE (req.subject) .with ({Status:3,Criticality:3})      
    })
    
    this.on ('POReject',async req => {
        await UPDATE (req.subject) .with ({Status:1,Criticality:1})
    })

    this.on ('POHold',async req => {
        await UPDATE (req.subject) .with ({Status:2,Criticality:2})
    })

    this.on ('error', async (err, req) => { 
        try{

        }catch(error){

        }        
    })

    return super.init()
}}
