using POPlainService from './po_plain_srv'; 

annotate POPlainService.POHeader with{
    PCode          @title : 'Plant Code';
    CompanyCode    @title : 'Company Code';
    PO_Number      @ID : 'PO Number' @title:'PO Number';      
    CreationDate   @title : 'Creation Date';
    DeliveryDate   @title : 'Delivery Date';
    Status         @title : 'Status';
    MadeBy      @title: 'Created By';
    Delete         @title: 'Delete';
    Pl_Master      @title: 'Plant Master';
    Cp_Master       @title: 'Company Master';
    S_Master        @title : 'Status Master';  
}
     

annotate POPlainService.POHeader with {
    Status @(Common : {
        Text            : S_Master.DESC,  
        TextArrangement : #TextFirst,
        ValueListWithFixedValues: true,   
        ValueList       : {
            Label          : 'Status',      
            CollectionPath : 'StatusMaster',                 
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'CODE',
                    LocalDataProperty   : Status
                },
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'DESC'
                }    
            ]   
        }
    });
}   

annotate POPlainService.POHeader with {
    @Common.Label : 'CompanyCode'
    @Common : {
        Text            : CompanyCode,
        TextArrangement : #TextFirst
    }
    @Common.ValueListWithFixedValues : false
    @Common.ValueList : {
        $Type : 'Common.ValueListType',
        Label : 'CompanyCode',
        CollectionPath : 'CompanyMaster',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : CompanyCode,
                ValueListProperty : 'CODE'
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'NAME'
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'DESC'   
            }
        ]
    }
    @Core.Description : 'Company Code'   
    CompanyCode
};    


annotate POPlainService.StatusMaster with {
    @Common.Label : 'DESC'
    @Common : {
        Text            : DESC,
        TextArrangement : #TextFirst
    }
    CODE   
};