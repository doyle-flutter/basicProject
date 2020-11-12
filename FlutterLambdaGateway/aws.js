const https = require('https')
let url = "https://api.airtable.com/v0/appwOWIDaRO0TiSDf/emp?api_key=KEY"

exports.handler = async function(event) {
  const promise = new Promise(function(resolve, reject) {
    https.get(url, (res) => {
        res.on("data", function(chunk) {
          resolve(JSON.parse(chunk));
        });
      
      }).on('error', (e) => {
        reject(Error(e))
      })
    })
  return promise
}
