var express = require('express');
var fs = require('fs');
var child_process = require('child_process');

var router = express.Router();

router.get('/', function(req, res, next) {
	res.render('index');
});

router.post('/', function(req, res, next) {
	var code = req.body.code;
	if(!code) {
		res.redirect("/");
		return
	}
	var ucode = code.replace(/\r/g, "\n");
	var tmpdir = "out/" + new Date().getTime();
	child_process.execSync('mkdir -p ' + tmpdir);
	fs.writeFileSync(tmpdir + '/prog.nit', ucode, 'utf-8');
	// TODO load answer
	var answer = "LOL"
	child_process.exec('./runtest.sh ' + tmpdir + '/prog.nit', {timeout: 5000},
	  function(err, stdout, stderr) {
		  try {
			  //child_process.execSync('rm -rf ' + tmpdir);
		  } catch(e) {
			  console.log(e);
		  }
		  res.render('index', {code: code, err: err, stdout: stdout, stderr: stderr, answer: answer});
	  });
});

module.exports = router;
