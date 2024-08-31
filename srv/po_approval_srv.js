const cds=require("@sap/cds")
const library=require("./Library/responseHandle")
module.exports=cds.service.impl(function(srv){
    this.on ('PurchaseApprove',async req => {
        await UPDATE (req.subject) .with ({Status:2,Criticality:3})      
    })
    
    this.on ('PurchaseReject',async req => {
        await UPDATE (req.subject) .with ({Status:3,Criticality:1})
    })

    this.on ('PurchaseComplete',async req => {
        await UPDATE (req.subject) .with ({Status:5})        
    })   

})