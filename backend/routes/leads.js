const express = require('express')
const { body, validationResult } = require('express-validator')
const router = express.Router()
const ghlService = require('../services/ghl')

// GET /api/leads - list leads
router.get('/', async (req, res) => {
  try {
    const leads = await ghlService.getLeads(req.query)
    res.json(leads)
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: 'Failed to fetch leads' })
  }
})

// POST /api/leads - create lead
router.post(
  '/',
  body('name').isString().notEmpty(),
  body('email').optional().isEmail(),
  body('phone').optional().isString(),
  async (req, res) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() })
    }

    try {
      const lead = await ghlService.createLead(req.body)
      res.status(201).json(lead)
    } catch (err) {
      console.error(err)
      res.status(500).json({ error: 'Failed to create lead' })
    }
  }
)

// PUT /api/leads/:id - update lead
router.put('/:id', async (req, res) => {
  try {
    const updated = await ghlService.updateLead(req.params.id, req.body)
    res.json(updated)
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: 'Failed to update lead' })
  }
})

module.exports = router
