const abtest = require('express').Router();
const db = require('../db/DBService')

// abtest.get('/', async (req, res) => {

// });

// abtest.get('/:abtestName', async (req, res) => {

// });

abtest.put('/start/:abtestName', async (req, res) => {

    const abtestName = req.params.abtestName

    try {
        // randomly allocate test group
        const {abtest_id: abtestId, groups} = await db.getAbtestByName(abtestName)
        if(abtestId === -1) 
            throw('failed to find abtest');
        const group = groups[Math.floor(Math.random() * groups.length)]

        const result = await db.startExperiment(req.userMetaCookie.userId, abtestName, group, abtestId)
        const abtestMeta = {
            allocationId: result.allocationId,
            allocatedGroup: result.group
        }
        
        // Set cookie with abtest info
        const abtestCookie = req.cookies.abtests || {};
        abtestCookie[abtestName] = abtestMeta;
        res.cookie('abtests', abtestCookie);

        res.status(200).json(abtestMeta);
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to start abtest'});
    }
});

abtest.get('/end/:abtestName', async (req, res) => {

    const abtestName = req.params.abtestName
    const abtestMeta = req.cookies.abtests[abtestName]

    try {
        if(!abtestMeta)
            throw('failed to read abtest meta from cookie')
        await db.setAbtestAllocationConversion(abtestMeta.allocationId)
        res.status(200).send();
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to set abtest conversion'});
    }
});

module.exports = abtest;
