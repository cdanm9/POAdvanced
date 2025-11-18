using POAnalyticsService from './po-analytics-service';     

   
annotate POAnalyticsService.POHeaders with{     
    plantCode          @title : 'Plant Code';
    companyCode    @title : 'Company Code';
    poNumber      @title : 'PO Number';
    deliveryDate   @title : 'Delivery Date';
    status         @title : 'Status';
    madeBy         @title: 'Created By';           
    to_POItems @title: 'Purchase Order Items';         
}    

//For Chart In Analytical List Page
annotate POAnalyticsService.POHeaders with @(
    Aggregation.ApplySupported : {
        Transformations          : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'search'
        ],
        GroupableProperties : [
            poNumber,
            plantCode,
            companyCode,
            madeBy    
        ],
        AggregatableProperties: [{
            $Type : 'Aggregation.AggregatablePropertyType',
            Property: status
        },
        {
          $Type:'Aggregation.AggregatablePropertyType',
          Property: totalAmount
        }]
    },   
    Analytics.AggregatedProperty #totalStatus: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : status,
    AggregationMethod : 'max',               
    Name : 'totalStatus',
    ![@Common.Label]: 'Max Status'   
      },
      Analytics.AggregatedProperty #totalAmount: {
        $Type : 'Analytics.AggregatedPropertyType',
        AggregatableProperty : totalAmount,
        AggregationMethod : 'max',          
        Name : 'totalAmount',
        ![@Common.Label]: 'Max Amount'   
      }
);

// Combining All For Headers In Analytical List Page
annotate POAnalyticsService.POHeaders with @(
  UI.Chart: {
    $Type : 'UI.ChartDefinitionType',
    Title: 'status',
    ChartType : #Column,   
    Dimensions: [
      plantCode,
      companyCode
    ],
    DimensionAttributes: [{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: plantCode,
      Role: #Category
    },{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: companyCode,
      Role: #Category2
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStatus]
    ],
    MeasureAttributes: [{
      $Type: 'UI.ChartMeasureAttributeType',
      DynamicMeasure: ![@Analytics.AggregatedProperty#totalStatus],
      Role: #Axis1
    }]
  },
  UI.PresentationVariant: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart',
    ],
  }
);

// For PCODE vs Total Status Graph
annotate POAnalyticsService.POHeaders with @(
  UI.Chart #plantCode: {
    $Type : 'UI.ChartDefinitionType',
    ChartType: #Bar,
    Dimensions: [
      plantCode
    ],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStatus]
    ]
  },
  UI.PresentationVariant #prevplantCode: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart#plantCode',
    ],
  },
  UI.DataPoint #status : {
        $Type                  : 'UI.DataPointType',
        Value                  : status,
        Title                  : 'Status',
        CriticalityCalculation : {
            $Type                   : 'UI.CriticalityCalculationType',
            ImprovementDirection    : #Maximize,
            DeviationRangeHighValue : 1000000,
            DeviationRangeLowValue  : 3000000
        },
        TrendCalculation       : {
            $Type                : 'UI.TrendCalculationType',
            ReferenceValue       : 1000,
            UpDifference         : 10,
            StrongUpDifference   : 100,
            DownDifference       : -10,
            StrongDownDifference : -100
        },
    },
    Identification                          : [{
        $Type : 'UI.DataField',
        Value : status
    }]
){
  plantCode @Common.ValueList #vlplantCode: {
    $Type : 'Common.ValueListType',
    CollectionPath : 'POHeaders',
    Parameters: [{
      $Type : 'Common.ValueListParameterInOut',
      ValueListProperty : 'plantCode',
      LocalDataProperty: plantCode   
    }],
    PresentationVariantQualifier: 'prevplantCode'
  }
}

// // For Company Code Vs Total Status Graph  
annotate POAnalyticsService.POHeaders with @(
  UI.Chart #companyCode: {
    $Type : 'UI.ChartDefinitionType',
    ChartType: #Bar,
    Dimensions: [
      companyCode
    ],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStatus]
    ]
  },
  UI.PresentationVariant #prevcompanyCode: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart#companyCode',
    ],
  }
){
  companyCode @Common.ValueList #vlcompanyCode: {
    $Type : 'Common.ValueListType',
    CollectionPath : 'POHeaders',
    Parameters: [{
      $Type : 'Common.ValueListParameterInOut',
      ValueListProperty : 'companyCode',   
      LocalDataProperty: companyCode
    }],
    PresentationVariantQualifier: 'prevcompanyCode'
  }   
}



annotate POAnalyticsService.POHeaders with @(
    UI: {
        SelectionFields  : [
            plantCode,
            companyCode
        ],    
        LineItem: [
            {  $Type : 'UI.DataField', Value : poNumber, },
            {  $Type : 'UI.DataField', Value : madeBy, },
            {  $Type : 'UI.DataField', Value : plantCode, },
            {  $Type : 'UI.DataField', Value : companyCode, },
            {  $Type : 'UI.DataField', Value : status, }

        ],
    }  
);
