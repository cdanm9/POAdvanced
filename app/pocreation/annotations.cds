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
            Value : deliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Value : madeBy,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Companies.name,
            Label : 'Company',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Plants.name,
            Label : 'Plant',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Statuses.desc,
            Label : 'Status',
        },
    ],
    UI.SelectionFields : [
        to_Plants_code,
        to_Companies_code,
        to_Statuses_code,
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
        } 
    ],
    UI.FieldGroup #Main : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : to_Plants_code,
                Label : 'Plant',
            },
            {
                $Type : 'UI.DataField',
                Value : to_Companies_code,
            },
            {
                $Type : 'UI.DataField',
                Value : deliveryDate,
            },
            {
                $Type : 'UI.DataField',
                Value : madeBy,
            },
            {
                $Type : 'UI.DataField',
                Value : remarks,
            },
        ],
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
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : to_Statuses.desc,
            ![@UI.TextArrangement] : #TextFirst
        },
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
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'price',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'plantCode',
                    LocalDataProperty : to_Materials.code,
                },
            ],
            Label : 'Materials',
        },
        Common.ValueListWithFixedValues : false
)};

annotate service.Materials with {
    code @Common.Text : name
};


annotate service.Plants with {
    name @Common.Text : code
};

annotate service.POHeaders with {
    to_Plants @(
        Common.Label : 'Plants',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Plants',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_Plants_code,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'city',
                },
            ],
            Label : 'Plants',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.POHeaders with {
    to_Companies @(
        Common.Label : 'Company ',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_Companies_code,
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
    )
};

annotate service.POHeaders with {
    to_Statuses @(
        Common.Label : 'Status ',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Statuses',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_Statuses_code,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'desc',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true,
    )
};

