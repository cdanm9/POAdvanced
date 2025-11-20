using POCreationService from './po-creation-service';  

annotate POCreationService.POHeaders with{
    plantCode          @title : 'Plant Code';
    companyCode    @title : 'Company Code';
    poNumber      @ID : 'PO Number';  
    deliveryDate   @title : 'Delivery Date';
    status         @title : 'Status';
    madeBy      @title: 'Made By';
    remarks    @title : 'Remarks';   
    to_Plants      @title: 'Plant Master';
    to_Companies       @title: 'Company Master';
    to_Statuses        @title : 'Status Master';
    to_POItems  @title: 'Purchase Order Items';
}

annotate POCreationService.Plants with{
    city @title : 'City';
    code @title : 'Plant';
    name @title : 'Name';
}
annotate POCreationService.Companies with{
    website @title : 'Website';
    code @title : 'Company';
    name @title : 'Name';
}

annotate POCreationService.POItems with{
    poItemNo      @title : 'PO Item Number';
    poNumber      @title : 'PO Number';
    materialCode       @title : 'Material Code';
    quantity     @title : 'Quantity';
    amount    @title : 'Amount';
    to_Materials @title :'Material Master';
    to_POHeaders @title: 'Purchase Order Header'
}

annotate POCreationService.POHeaders with @(
    UI: {
        HeaderInfo: {  
			TypeName: 'Purchase Header',
			TypeNamePlural: 'Purchase Order Header',
			Title          : {
                $Type : 'UI.DataField',
                Value : poNumber
            },
			Description : {
				$Type: 'UI.DataField',
				Value: madeBy
			}
		},
        SelectionFields: [poNumber],
        LineItem:[    
            {Value: poNumber},
            {Value: plantCode},
            {Value: companyCode},
            {Value: deliveryDate},
            {Value: status},
            {Value: madeBy}
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Label: 'PO Header', Target: '@UI.FieldGroup#Main'},
            {$Type: 'UI.ReferenceFacet', Label: 'PO Items', Target: 'to_POItems/@UI.LineItem' }
        ],
        FieldGroup#Main: {
            Data: [
                {Value: plantCode},
                {Value: companyCode},
                {Value: deliveryDate},
                {Value: madeBy},   
                {Value: remarks}
            ]
        }
    }
){};

annotate POCreationService.POItems with @(
    UI: {
        LineItem: [
            {Value: poItemNo},
            {Value: materialCode},
            {Value: quantity},
            {Value: amount},
            {Value:to_Materials.image},
        ]
    }
){};

