const express = require('express')
const os = require('os')
const app = express()
const port = 8422

app.get('/', (req, res) => {
	let hostname = os.hostname();
	res.send(hostname)
})

app.listen(port, () => {
	console.log(`Hostname provider app listening ...`)
})
