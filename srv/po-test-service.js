const cds=require("@sap/cds")

module.exports=cds.service.impl(async function(srv){
    const { POHeaders, POItems,Books} = this.entities;
    const kymacap  = await cds.connect.to('kymacap');  

    this.on('error', async req => {
    });

    this.on('READ', Books, async (req, next) => { 
        return kymacap.run(req.query);
    });
})