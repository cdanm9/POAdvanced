const cds=require("@sap/cds")  

module.exports=cds.service.impl(function(srv){
    const { POHeaders, POItems } = this.entities;

    this.before('NEW', POHeaders, async req => {
        try{

        }catch(oError){

        }
    })

    this.before('NEW', POItems, async req => {
        try{

        }catch(oError){

        }
    })

})