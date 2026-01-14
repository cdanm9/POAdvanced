/* checksum : b7a4a7f659bdabc15081b655cfbcb790 */
@cds.external : true
service kymacap {
  @cds.external : true
  @cds.persistence.skip : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  entity Books {
    key ID : Integer not null;
    title : String;
    stock : Integer;
  };
};

