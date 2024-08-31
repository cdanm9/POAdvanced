const cds=require("@sap/cds")
const library=require("./Library/responseHandle")

module.exports=cds.service.impl(function(srv){
    const { POHeader, POItem } = this.entities;

    this.before('NEW', POHeader, async req => {
        try{

        }catch(oError){

        }
    })

    this.before('NEW', POItem, async req => {
        try{

        }catch(oError){

        }
    })

})


// class POReportService extends cds.ApplicationService{
//     async init(){
//         const { POHeader, POItem } = this.entities;

//         this.before('NEW', POHeader, async req => {
//         })

//         this.before('NEW', POItem, async req => {
//         })

//         await super.init()   
//     }
// }

// module.exports = POReportService