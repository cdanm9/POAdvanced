const cds=require("@sap/cds")
const {executeHttpRequest}=require("@sap-cloud-sdk/http-client")

module.exports=cds.service.impl(async function(srv){
    const { POHeaders, POItems,Books} = this.entities;   
    const eKymaCap=await cds.connect.to('kymacap')

    this.on('error', async req => {
    });

    this.on('READ', Books, async (req,next) => {
        return await eKymaCap.run(req.query)
    })
})