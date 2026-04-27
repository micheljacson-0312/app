const express = require('express')
const router = express.Router()

const leadsRouter = require('./leads')
const opportunitiesRouter = require('./opportunities')
const whatsappRouter = require('./whatsapp')

router.use('/leads', leadsRouter)
router.use('/opportunities', opportunitiesRouter)
router.use('/whatsapp', whatsappRouter)

module.exports = router
