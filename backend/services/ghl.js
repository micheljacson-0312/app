const axios = require('axios')
const dotenv = require('dotenv')

dotenv.config()

const GHL_BASE = process.env.GHL_API_BASE || 'https://rest.gohighlevel.com/v1'
const TOKEN = process.env.GHL_PRIVATE_TOKEN

if (!TOKEN) {
  console.warn('Warning: GHL_PRIVATE_TOKEN is not set')
}

const client = axios.create({
  baseURL: GHL_BASE,
  headers: {
    Authorization: `Bearer ${TOKEN}`,
    'Content-Type': 'application/json'
  },
  timeout: 15000
})

async function getLeads(query = {}) {
  // Simple pagination/filter support via query params
  const params = {}
  if (query.page) params.page = query.page
  if (query.limit) params.limit = query.limit

  const resp = await client.get('/contacts', { params })
  // Normalize shape for frontend
  return resp.data
}

async function createLead(payload) {
  const body = {
    // GHL contact model expects custom fields; map basic fields
    name: payload.name,
    email: payload.email,
    phone: payload.phone,
    // allow passing custom fields
    ...payload.customFields
  }
  const resp = await client.post('/contacts', body)
  return resp.data
}

async function updateLead(id, payload) {
  const body = {
    ...payload
  }
  const resp = await client.put(`/contacts/${encodeURIComponent(id)}`, body)
  return resp.data
}

module.exports = {
  getLeads,
  createLead,
  updateLead
}
