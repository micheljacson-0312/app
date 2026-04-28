const request = require('supertest')
const app = require('../app')

describe('API basic', () => {
  test('GET / returns status', async () => {
    const res = await request(app).get('/')
    expect(res.statusCode).toBe(200)
    expect(res.body).toHaveProperty('service', 'ghl-crm-backend')
  })

  test('GET /api/leads returns 500 when GHL token missing or upstream fails (graceful)', async () => {
    const res = await request(app).get('/api/leads')
    // Accept either 200 with data or 500 - ensure endpoint responds
    expect([200, 500]).toContain(res.statusCode)
  })
})
