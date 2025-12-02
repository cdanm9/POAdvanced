const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')

describe('POBaseService OData APIs', () => {

  it('serves POBaseService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/pobase/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"11041020-021e-4dfd-a679-f35850b0e4cc","poNumber":43},
    ])
  })

})
