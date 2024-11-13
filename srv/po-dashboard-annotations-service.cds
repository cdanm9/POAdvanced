using PODashboardService from './po-dashboard-service'; 

annotate PODashboardService.POItems with {    
  @Analytics.Dimension      : true
  materialCode @(title  : 'Material Code');  
  @Analytics.Measure        : true   
  @Core.Computed
  quantity @(title                   : 'Quantity');     
  @Analytics.Measure        : true   
  @Core.Computed
  amount @(title                   : 'Amount');   
}

annotate PODashboardService.POHeaders with {
  @Analytics.Dimension      : true
  madeBy @(title  : 'Made By');
  @Analytics.Measure        : true   
  @Core.Computed   
  totalAmount @(title : 'Total Amount');    
  @Analytics.Dimension      : true
  plantCode @(title  : 'Plant'); 
  @Analytics.Dimension      : true
  companyCode @(title  : 'Company');    
  @Analytics.Measure        : true   
  deliveryDate @(title : 'Delivery Date');             
}  

annotate PODashboardService.Statuses with {
  @Analytics.Dimension      : true
  code @(title  : 'Status Code');   
  @Analytics.Measure        : true   
  desc @(title : 'Status');                 
}  