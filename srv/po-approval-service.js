const cds=require("@sap/cds")
module.exports=cds.service.impl(function(srv){
    this.on ('POApprove',async req => {
        await UPDATE (req.subject) .with ({Status:3,Criticality:3})      
    })
    
    this.on ('POReject',async req => {
        await UPDATE (req.subject) .with ({Status:1,Criticality:1})
    })

    this.on ('POHold',async req => {
        await UPDATE (req.subject) .with ({Status:2,Criticality:2})
    })


})