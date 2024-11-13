const cds = require("@sap/cds");  
const cds_swagger = require ('cds-swagger-ui-express')

cds.on ('bootstrap', app => {app.use(cds_swagger())}).on('serving', service => {
    addLinkToGraphQl(service)        
})   

function addLinkToGraphQl(service) {
    const provider = (entity) => {
        if (entity) return 
        let isGraphQL
        for (const endpoint of service.endpoints) {
            if(endpoint && endpoint.kind === 'graphql'){
                isGraphQL = true
            }
        }
        if(isGraphQL){
            return { href: 'graphql', name: 'GraphQl', title: 'Show in GraphQL' }
        }     
    }

    service.$linkProviders ? service.$linkProviders.push(provider) : service.$linkProviders = [provider]
}
module.exports = cds.server;  


