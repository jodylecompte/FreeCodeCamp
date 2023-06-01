// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});

app.get("/api/:date?", function(req, res) {
  const { date } = req.params;
  let asDate;

   if (!date || date === "") {
    // If no date is provided, use the current date
    asDate = new Date();
  } else if (isNaN(date)) {
    // If it's not a number, try parsing it as a text date
    asDate = new Date(date);
  } else {
    // If it's a number, treat it as a UNIX timestamp
    asDate = new Date(parseInt(date));
  }

  if (isNaN(asDate)) {
    return res.json({
      error: "Invalid Date",
    });
  }

  res.json({
    unix: asDate.getTime(),
    natural: asDate.toUTCString()
  });
});

// listen for requests :)
var listener = app.listen(process.env.PORT, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
