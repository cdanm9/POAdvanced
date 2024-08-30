const cds = require("@sap/cds");
// const cov2ap = require("@sap/cds-odata-v2-adapter-proxy");
// cds.on("bootstrap", (app) => {
//     app.use(cov2ap());          
// });
cds.on('serving', service => {
    addLinkToGraphQl(service)        
})

function addLinkToGraphQl(service) {
    const provider = (entity) => {
        if (entity) return // avoid link on entity level, looks too messy
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
    // Needs @sap/cds >= 4.4.0
    service.$linkProviders ? service.$linkProviders.push(provider) : service.$linkProviders = [provider]
}
module.exports = cds.server;  


// const express = require('express');
// const passport = require('passport');
// const xsenv = require('@sap/xsenv');
// const JWTStrategy = require('@sap/xssec').JWTStrategy;

// //configure passport
// const xsuaaService = xsenv.getServices({ myXsuaa: { tag: 'xsuaa' }});
// const xsuaaCredentials = xsuaaService.myXsuaa; 
// const jwtStrategy = new JWTStrategy(xsuaaCredentials)

// // configure express server with authentication middleware
// passport.use(jwtStrategy);
// const app = express();

// // Middleware to read JWT sent by client
// function jwtLogger(req, res, next) {
//    console.log('===> Decoding auth header' )
//    const jwtToken = readJwt(req)
//    if(jwtToken){
//       console.log('===> JWT: audiences: ' + jwtToken.aud);
//       console.log('===> JWT: scopes: ' + jwtToken.scope);
//       console.log('===> JWT: client_id: ' + jwtToken.client_id);
//    }

//    next()
// }

// app.use(jwtLogger)
// app.use(passport.initialize());
// app.use(passport.authenticate('JWT', { session: false }));

// // app endpoint with authorization check
// app.get('/getData', function(req, res){       
//    console.log('===> Endpoint has been reached. Now checking authorization')
//    const MY_SCOPE = xsuaaCredentials.xsappname + '.ZPO_ADMIN'// scope name copied from xs-security.json
//    if(req.authInfo.checkScope(MY_SCOPE)){
//       res.send('The endpoint was properly called, role available, delivering data');   
//    }else{
//       const jwtToken = readJwt(req)
//       const availableScopes = jwtToken ? jwtToken.scope : {}
   
//       return res.status(403).json({
//          error: 'Unauthorized',
//          message: `Missing required role: <ZPO_ADMIN>. Available scopes: ${availableScopes}`
//      });
//    }
// });

// const readJwt = function(req){
//    const authHeader = req.headers.authorization;
//    if (authHeader){
//       const theJwtToken = authHeader.substring(7);
//       if(theJwtToken){
//          const jwtBase64Encoded = theJwtToken.split('.')[1];
//          if(jwtBase64Encoded){
//             const jwtDecoded = Buffer.from(jwtBase64Encoded, 'base64').toString('ascii');
//             return JSON.parse(jwtDecoded);           
//          }
//       }
//    }
// }

// // start server
// app.listen(process.env.PORT || 8080, () => {
//    console.log('Server running...')
// })