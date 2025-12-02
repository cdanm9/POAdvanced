const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')
axios.defaults.auth = { username: 'no_user_found_for_roles_authenticated-user', password: '' }

describe('PODashboardService OData APIs', () => {

  it('serves PODashboardService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/podashboard/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"21393444-7354-4781-b7e4-997e3b78fe2d","poNumber":54},
    ])
  })

})
