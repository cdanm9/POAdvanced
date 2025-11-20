using POCreationService as service from '../../srv/po-creation-service';
using from '../../srv/po-creation-annotations-service';

annotate service.POHeaders with @Common.SemanticKey: [poNumber];

annotate service.POHeaders with {
    to_Plants @(
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
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'to_Companies_code',
                    LocalDataProperty : to_Companies_code,
                    Label:'Company'
                },
            ],
            Label : 'Plants',
        },
        Common.Label : 'Plant',
        Common.ValueListWithFixedValues : false,
        Common.Text : to_Plants.name,
        Common.Text.@UI.TextArrangement : #TextFirst,
    )
};

annotate service.POHeaders with {
    to_Companies @(
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
                    ValueListProperty : 'desc',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'website',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Company',
        },
        Common.Label : 'Company',
        Common.ValueListWithFixedValues : false,
        Common.Text : to_Companies.desc,
        Common.Text.@UI.TextArrangement : #TextFirst,
    )
};

annotate service.POHeaders with {
    to_Statuses @(
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
        Common.Label : 'Status',
        Common.ValueListWithFixedValues : true,
        Common.Text : to_Statuses.desc,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.POHeaders with {
    poNumber @(
        Common.Label : 'PO Number',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'POHeaders',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : poNumber,
                    ValueListProperty : 'poNumber',
                },
            ],
            Label : 'PO Number',
            PresentationVariantQualifier : 'vh_POHeaders_poNumber',
        },
        Common.ValueListWithFixedValues : false,
        )
};

annotate service.POHeaders with @(
    UI.SelectionFields : [
        poNumber,
        to_Companies_code,
        to_Plants_code,
        to_Statuses_code,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : poNumber,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Companies_code,
            @UI.Importance : #Medium,
            Label:'Company'
        },
        {
            $Type : 'UI.DataField',
            Value : to_Plants_code,
        },
        {
            $Type : 'UI.DataField',
            Value : deliveryDate,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : madeBy,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POHold',
            Label : 'PO Hold',
            Criticality : #Negative,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POApprove',
            Label : 'PO Approve',
            Criticality : #Positive,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POReject',
            Label : 'PO Reject',
            Criticality :#Critical
        },
        {
            $Type : 'UI.DataField',
            Value : to_Statuses_code,
            Criticality : to_Statuses_code,
            @UI.Importance : #High,
        },
    ],
    UI.PresentationVariant #vh_POHeaders_poNumber : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [
            {
                $Type : 'Common.SortOrderType',
                Property : poNumber,
                Descending : true,
            },
        ],
    },
    UI.FieldGroup #Main : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : to_Plants_code,
            },
            {
                $Type : 'UI.DataField',
                Value : to_Companies_code,
                Label : 'Company',
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
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Header',
            Target : '@UI.FieldGroup#Main',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Items',
            Target : 'to_POItems/@UI.SelectionPresentationVariant#table',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Attachments',
            ID : 'POAttachments',
            Target : 'to_POAttachments/@UI.LineItem#POAttachments',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Header',
        TypeNamePlural : 'Purchase Order Header',
        Title : {
            $Type : 'UI.DataField',
            Value : ID,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : poNumber,
        },
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POHold',
            Label : 'PO Hold',
            Inline: true,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POApprove',
            Label : 'PO Approve',
            Criticality : #Positive,
            Inline: true
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.POReject',
            Label : 'PO Reject',
            Criticality : #Negative,
            Inline: true
        },
        
    ],
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : poNumber,
                    Descending : true,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
);

annotate service.POItems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : poItemNo,
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
    ],
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : poItemNo,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
);

annotate service.POHeaders with {
    companyCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Companies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companyCode,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Company',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.Companies with {
    code @(
        Common.Text : desc,
        Common.Text.@UI.TextArrangement : #TextFirst,
)};

annotate service.POHeaders with {
    plantCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Plants',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plantCode,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Plants',
            PresentationVariantQualifier : 'vh_POHeaders_plantCode',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Plants with @(
    UI.PresentationVariant #vh_POHeaders_plantCode : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [
            {
                $Type : 'Common.SortOrderType',
                Property : code,
                Descending : false,
            },
        ],
    }
);

annotate service.Plants with {
    to_Companies @Common.Text : 'Company';
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextFirst,
)};

annotate service.POAttachments with @(
    UI.LineItem #POAttachments : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'File Name',
        },
        {
            $Type : 'UI.DataField',
            Value : mimeType,
            Label : 'File Type',
        },
        {
            $Type : 'UI.DataField',
            Value : content,
            Label : 'Content',
        },
    ]
);

annotate service.POHeaders with {
    remarks @UI.MultiLineText : true
};

