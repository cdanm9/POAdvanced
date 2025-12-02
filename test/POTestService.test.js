const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')
axios.defaults.auth = { username: 'no_user_found_for_roles_authenticated-user', password: '' }

describe('POTestService OData APIs', () => {

  it('serves POTestService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/potest/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"25143732-e793-444d-a8ac-2b62a4af524a","poNumber":49},
    ])
  })

})
