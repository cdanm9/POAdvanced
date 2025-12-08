const cds=require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");
// module.exports=cds.service.impl(function(srv){

module.exports= class POCreationService extends cds.ApplicationService { async init() {
    const db=cds.connect.to('db')
    const { POHeaders, POItems,POAttachments,POEvents} = this.entities;   
    this.before('NEW', POHeaders.drafts, async req => {
        req.data.to_Statuses_code=0;          
    })

    this.before('CREATE', POHeaders, async req => { 
        let { maxPoNumber } = await SELECT.one (`max(poNumber) as maxPoNumber`) .from (POHeaders);
        req.data.poNumber = (maxPoNumber == null) ? 100001 : ++maxPoNumber;
        req.data.to_Statuses_code=5; 
        let{ poNumber, to_Statuses_code: status, msg = "PO Created Successfully" } = req.data;
        this.emit('POAddEvent',{poNumber,status,msg})
    });

    this.before('SAVE', POHeaders, async req => {
        
    })
    this.after('SAVE', POHeaders.drafts, async (results,req)=> {
        
    })
        
    this.before('NEW', POItems.drafts, async req => {
        let { maxPoItemNo } = await SELECT.one(`max(poItemNo) as maxPoItemNo`).from(POItems.drafts).where({to_POHeaders_ID:req.data.to_POHeaders_ID});
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


    this.on ('POApprove',async (req,next) => {
        let{ poNumber, status=3, msg = "PO Approved Successfully" 
        } = await SELECT .one .from(POHeaders) .where(req?.params[0])
        this.emit('POAddEvent',{poNumber,status,msg})
        await UPDATE (req.subject) .with ({to_Statuses_code:3,Criticality:3})    
       
    })
    
    this.on ('POReject',async (req,next) => {

        let{ poNumber, status=1, msg = "PO Rejected Successfully" 
        } = await SELECT .one .from(POHeaders) .where(req?.params[0])
        this.emit('POAddEvent',{poNumber,status,msg})
        await UPDATE (req.subject) .with ({to_Statuses_code:1,Criticality:1})
    })

    this.on ('POHold',async (req,next) => {
        let{ poNumber, status=1, msg = "PO Held Successfully" 
        } = await SELECT .one .from(POHeaders) .where(req?.params[0])
        this.emit('POAddEvent',{poNumber,status,msg})
        await UPDATE (req.subject) .with ({to_Statuses_code:2,Criticality:2})
    })
    this.on ('POAddEvent',async (req) => {
        await INSERT(req.data) .into(POEvents)
    })

    this.after('POAddEvent/#succeeded', (data, req) => {
        // `data` is the result of the event processor
        console.log('Events Addition Successful', data)
    })
    this.after('POAddEvent/#failed', (data, req) => {
        // `data` is the result of the event processor
        console.log('Events Addition Failed', data)
    })

    this.on ('error', (err, req) => { 
        try{

        }catch(error){

        }        
    })

    let job=PO Event cds.spawn ({ every: 60000  }, async ()=>{
    })

    job.on('succeeded', (req)=>{
        console.log('succeeded')
    })

    return super.init()
}}
