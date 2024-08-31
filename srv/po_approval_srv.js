const cds=require("@sap/cds")
const library=require("./Library/responseHandle")
module.exports=cds.service.impl(function(srv){
<<<<<<< HEAD

=======
>>>>>>> 9318e7ab87e3bde0cad583bc9c454f554d515989
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