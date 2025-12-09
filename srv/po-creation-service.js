const cds=require("@sap/cds");
const nodemailer = require('nodemailer');
const email_library=require('./lib/email-library')
// module.exports=cds.service.impl(function(srv){

module.exports= class POCreationService extends cds.ApplicationService { async init() {
    const db=await cds.connect.to('db')
    const { POHeaders, POItems,POAttachments,POEvents,Credentials,EmailTemplates} = this.entities;   
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

    let job=cds.spawn ({ every: 86400000  }, async (req)=>{
        this.emit('sendMail',{type:"initial"})
    })
    // let job=cds.spawn ({ every: 60000  }, async (req)=>{
    //     this.emit('sendMail',{type:"initial"})
    // })


    this.on('sendMail',async(req)=>{
        const {clientId,clientSecret,refToken,username,password,passcode}=await db.run(SELECT .one .from(Credentials) .where({type:'mail'}));
        const transporter = nodemailer.createTransport({
            service: "Gmail",
            auth: {
                user:username,
                pass:passcode
            }
        });
        let oEmailData=await email_library.getEmailTemplate(db,req?.data?.type,EmailTemplates);
        const mailOptions = {
            from: username,
            to: username,
            subject: oEmailData.subject,
            html:oEmailData.template
        };
        let oMailResponse=await transporter.sendMail(mailOptions);
    })

    job.on('succeeded', (req,next)=>{
        console.log('succeeded')
    })

    return super.init()
}}




