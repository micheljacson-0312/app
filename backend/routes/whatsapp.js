const express = require('express')
const router = express.Router()
const ghlService = require('../services/ghl')

// POST /api/whatsapp/send - craft whatsapp link or trigger message via GHL if supported
router.post('/send', async (req, res) => {
  try {
    const { phone, message } = req.body
    if (!phone) return res.status(400).json({ error: 'phone is required' })

    // Return a whatsapp:// link or web.whatsapp link the app can open
    const encoded = encodeURIComponent(message || '')
    const whatsappUrl = `https://wa.me/${phone}?text=${encoded}`
    res.json({ url: whatsappUrl })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: 'Failed to create whatsapp link' })
  }
})

module.exports = router
