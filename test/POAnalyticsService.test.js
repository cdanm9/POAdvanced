const cds = require('@sap/cds')

const { GET, POST, expect, axios } = cds.test (__dirname+'/..')

describe('POAnalyticsService OData APIs', () => {

  it('serves POAnalyticsService.POHeaders', async () => {
    const { data } = await GET `/odata/v4/poanalytics/POHeaders ${{ params: { $select: 'ID,poNumber' } }}`
    expect(data.value).to.containSubset([
      {"ID":"13976123-32a7-47f4-936d-66269a2b369e","poNumber":55},
    ])
  })

})
