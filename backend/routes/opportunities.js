const express = require('express')
const router = express.Router()
const ghlService = require('../services/ghl')

// GET /api/opportunities - list opportunities (deals)
router.get('/', async (req, res) => {
  try {
    const ops = await ghlService.getOpportunities(req.query)
    res.json(ops)
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: 'Failed to fetch opportunities' })
  }
})

// POST /api/opportunities - create opportunity
router.post('/', async (req, res) => {
  try {
    const op = await ghlService.createOpportunity(req.body)
    res.status(201).json(op)
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: 'Failed to create opportunity' })
  }
})

module.exports = router
