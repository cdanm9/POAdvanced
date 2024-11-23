# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

## CURL

user: northbreeze $ curl -H "Content-Type: application/json" -d '{"ProductID":77,"ProductName":"Original Frankfurter grüne Soße","UnitsInStock":32}' http://localhost:4004/odata/v4/main/Products
{"@odata.context":"$metadata#Products/$entity","ProductID":77,"ProductName":"Original Frankfurter grüne Soße","UnitsInStock":32}


user: northbreeze $ curl -H "Content-Type: application/json" -d '{"UnitsInStock":1}' -X PATCH "http://localhost:4004/odata/v4/main/Products(1)"
{"@odata.context":"$metadata#Products/$entity","ProductID":1,"ProductName":"Chai","UnitsInStock":1}


user: northbreeze $ curl -X DELETE "http://localhost:4004/odata/v4/main/Products(77)"


