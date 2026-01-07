const cds=require("@sap/cds")
const {executeHttpRequest}=require("@sap-cloud-sdk/http-client")

module.exports=cds.service.impl(async function(srv){
    const { POHeaders, POItems} = this.entities;   

    this.on('error', async req => {
    });
})