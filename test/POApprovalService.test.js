const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')

describe('POApprovalService OData APIs', () => {

  it('serves POApprovalService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/poapproval/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"11077614-9037-49ad-b4db-37caa28a5882","poNumber":10},
    ])
  })

})
