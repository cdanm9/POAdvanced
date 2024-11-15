using POCreationService as service from '../../srv/po-creation-service';
using from '../../srv/po-creation-annotations-service';

annotate service.POHeaders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : poNumber,
            Label : 'PO Number',
        },
        {
            $Type : 'UI.DataField',
            Value : plantCode,
        },
        {
            $Type : 'UI.DataField',
            Value : companyCode,
        },
        {
            $Type : 'UI.DataField',
            Value : deliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : madeBy,
        },
    ],
    UI.SelectionFields : [
        plantCode,
        companyCode,
        status,
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Header',
            Target : '@UI.FieldGroup#Main',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Items',
            Target : 'to_POItems/@UI.LineItem',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Attachments',
            ID : 'POAttachments',
            Target : 'to_POAttachments/@UI.LineItem#POAttachments',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order Header',
        TypeNamePlural : 'Purchase Order Header',
        Title : {
            $Type : 'UI.DataField',
            Value : poNumber,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : madeBy,
        },
    },
);

annotate service.POHeaders with {
    poNumber @Common.Label : 'PO Number'
};

annotate service.POHeaders with {
    plantCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Plants',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plantCode,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Plants',
        },
        Common.ValueListWithFixedValues : true,
        Common.Label : 'Plant ',
)};

annotate service.Plants with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.POHeaders with {
    companyCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companyCode,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'desc',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'website',
                },
            ],
            Label : 'Company',
        },
        Common.ValueListWithFixedValues : false,
        Common.Label : 'Company ',
)};

annotate service.Companies with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.POHeaders with {
    status @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Statuses',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'desc',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.Statuses with {
    code @Common.Text : desc
};

annotate service.POItems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : poItemNo,
            Label : 'PO Item No',
        },
        {
            $Type : 'UI.DataField',
            Value : materialCode,
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
        },
        {
            $Type : 'UI.DataField',
            Value : amount,
        },
    ]
);

annotate service.POAttachments with @(
    UI.LineItem #POAttachments : [
        {
            $Type : 'UI.DataField',
            Value : poNumber,
            Label : 'PO Number',
        },
        {
            $Type : 'UI.DataField',
            Value : content,
            Label : 'File',
        },
    ]
);

annotate service.POHeaders with {
    remarks @UI.MultiLineText : true
};

annotate service.POItems with {
    materialCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Materials',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : materialCode,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'desc',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'plantCode',
                    LocalDataProperty : to_Materials.plantCode,
                },
            ],
            Label : 'Materials',
        },
        Common.ValueListWithFixedValues : false
)};

annotate service.Materials with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

