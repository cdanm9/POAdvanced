const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')

describe('POCreationService OData APIs', () => {

  it('serves POCreationService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/pocreation/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"29160352-9ca8-4043-9ce2-a4cb8f20b806","poNumber":21},
    ])
  })

})
