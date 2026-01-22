const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')

describe('POCreationService OData APIs', () => {

  it('serves POCreationService.POHeaders', async () => {
    const { data ,status} = await GET `/odata/v4/pocreation/POHeaders`
    expect(data.value).to.be.an('array')
    expect(status).to.equal(200) 
  })

})
