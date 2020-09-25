var http = require('http');
var express = require('express');
const path = require('path');
var bodyParser = require('body-parser');
var nodemailer=require('nodemailer');
var check=require('./algo.js')
const router = express.Router();

var urlencodedParser = bodyParser.urlencoded({ extended: false });
var app= express()
app.use(express.static('res'));

//---------------------------------------------------------------------------------------



//Firebase setup start
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://travelsolution-450cf.firebaseio.com"
});
//Firebase setup end

//Extracting Data from Firebase
const db = admin.firestore();

var data={}

var total_bus={}
var total_busno={}
var total_metro={}
var total_metroline={}
var usage_data={}



async function loadData(){



	const usage=await db.collection('usage').doc('1').get()
	usage_detail=usage.data()

	usage_data['bus']=usage_detail['bus']
	usage_data['metro']=usage_detail['metro']
	usage_data['train']=usage_detail['train']
	usage_data['flight']=usage_detail['flight']


	const bus_monday= await db.collection('bus').doc('monday').get()
	bus_detail=bus_monday.data()
	
	

	total_bus['monday']=bus_detail['1']+bus_detail['2']+bus_detail['3']+bus_detail['4']+bus_detail['5']+bus_detail['6']+bus_detail['7']+bus_detail['8']+bus_detail['9']+bus_detail['10']+bus_detail['11']+bus_detail['12']+bus_detail['13']+bus_detail['14']+bus_detail['15']

	const bus_tuesday= await db.collection('bus').doc('tuesday').get()
	bus_detail_1=bus_tuesday.data()
	
	

	total_bus['tuesday']=bus_detail_1['1']+bus_detail_1['2']+bus_detail_1['3']+bus_detail_1['4']+bus_detail_1['5']+bus_detail_1['6']+bus_detail_1['7']+bus_detail_1['8']+bus_detail_1['9']+bus_detail_1['10']+bus_detail_1['11']+bus_detail_1['12']+bus_detail_1['13']+bus_detail_1['14']+bus_detail_1['15']

	const bus_wednesday= await db.collection('bus').doc('wednesday').get()
	bus_detail_2=bus_wednesday.data()
	
	

	total_bus['wednesday']=bus_detail_2['1']+bus_detail_2['2']+bus_detail_2['3']+bus_detail_2['4']+bus_detail_2['5']+bus_detail_2['6']+bus_detail_2['7']+bus_detail_2['8']+bus_detail_2['9']+bus_detail_2['10']+bus_detail_2['11']+bus_detail_2['12']+bus_detail_2['13']+bus_detail_2['14']+bus_detail_2['15']

	const bus_thursday= await db.collection('bus').doc('thursday').get()
	bus_detail_3=bus_thursday.data()
	
	

	total_bus['thursday']=bus_detail_3['1']+bus_detail_3['2']+bus_detail_3['3']+bus_detail_3['4']+bus_detail_3['5']+bus_detail_3['6']+bus_detail_3['7']+bus_detail_3['8']+bus_detail_3['9']+bus_detail_3['10']+bus_detail_3['11']+bus_detail_3['12']+bus_detail_3['13']+bus_detail_3['14']+bus_detail_3['15']

	const bus_friday= await db.collection('bus').doc('friday').get()
	bus_detail_4=bus_friday.data()
	
	

	total_bus['friday']=bus_detail_4['1']+bus_detail_4['2']+bus_detail_4['3']+bus_detail_4['4']+bus_detail_4['5']+bus_detail_4['6']+bus_detail_4['7']+bus_detail_4['8']+bus_detail_4['9']+bus_detail_4['10']+bus_detail_4['11']+bus_detail_4['12']+bus_detail_4['13']+bus_detail_4['14']+bus_detail_4['15']

	const bus_saturday= await db.collection('bus').doc('saturday').get()
	bus_detail_5=bus_saturday.data()
	
	

	total_bus['saturday']=bus_detail_5['1']+bus_detail_5['2']+bus_detail_5['3']+bus_detail_5['4']+bus_detail_5['5']+bus_detail_5['6']+bus_detail_5['7']+bus_detail_5['8']+bus_detail_5['9']+bus_detail_5['10']+bus_detail_5['11']+bus_detail_5['12']+bus_detail_5['13']+bus_detail_5['14']+bus_detail_5['15']

	const bus_sunday= await db.collection('bus').doc('sunday').get()
	bus_detail_6=bus_sunday.data()
	
	

	total_bus['sunday']=bus_detail_6['1']+bus_detail_6['2']+bus_detail_6['3']+bus_detail_6['4']+bus_detail_6['5']+bus_detail_6['6']+bus_detail_6['7']+bus_detail_6['8']+bus_detail_6['9']+bus_detail_6['10']+bus_detail_6['11']+bus_detail_6['12']+bus_detail_6['13']+bus_detail_6['14']+bus_detail_6['15']

	total_busno['1']=bus_detail['1']+bus_detail_1['1']+bus_detail_2['1']+bus_detail_3['1']+bus_detail_4['1']+bus_detail_5['1']+bus_detail_6['1']
	total_busno['2']=bus_detail['2']+bus_detail_1['2']+bus_detail_2['2']+bus_detail_3['2']+bus_detail_4['2']+bus_detail_5['2']+bus_detail_6['2']
	total_busno['3']=bus_detail['3']+bus_detail_1['3']+bus_detail_2['3']+bus_detail_3['3']+bus_detail_4['3']+bus_detail_5['3']+bus_detail_6['3']
	total_busno['4']=bus_detail['4']+bus_detail_1['4']+bus_detail_2['4']+bus_detail_3['4']+bus_detail_4['4']+bus_detail_5['4']+bus_detail_6['4']
	total_busno['5']=bus_detail['5']+bus_detail_1['5']+bus_detail_2['5']+bus_detail_3['5']+bus_detail_4['5']+bus_detail_5['5']+bus_detail_6['5']
	total_busno['6']=bus_detail['6']+bus_detail_1['6']+bus_detail_2['6']+bus_detail_3['6']+bus_detail_4['6']+bus_detail_5['6']+bus_detail_6['6']
	total_busno['7']=bus_detail['7']+bus_detail_1['7']+bus_detail_2['7']+bus_detail_3['7']+bus_detail_4['7']+bus_detail_5['7']+bus_detail_6['7']
	total_busno['8']=bus_detail['8']+bus_detail_1['8']+bus_detail_2['8']+bus_detail_3['8']+bus_detail_4['8']+bus_detail_5['8']+bus_detail_6['8']
	total_busno['9']=bus_detail['9']+bus_detail_1['9']+bus_detail_2['9']+bus_detail_3['9']+bus_detail_4['9']+bus_detail_5['9']+bus_detail_6['9']
	total_busno['10']=bus_detail['10']+bus_detail_1['10']+bus_detail_2['10']+bus_detail_3['10']+bus_detail_4['10']+bus_detail_5['10']+bus_detail_6['10']
	total_busno['11']=bus_detail['11']+bus_detail_1['11']+bus_detail_2['11']+bus_detail_3['11']+bus_detail_4['11']+bus_detail_5['11']+bus_detail_6['11']
	total_busno['12']=bus_detail['12']+bus_detail_1['12']+bus_detail_2['12']+bus_detail_3['12']+bus_detail_4['12']+bus_detail_5['12']+bus_detail_6['12']
	total_busno['13']=bus_detail['13']+bus_detail_1['13']+bus_detail_2['13']+bus_detail_3['13']+bus_detail_4['13']+bus_detail_5['13']+bus_detail_6['13']
	total_busno['14']=bus_detail['14']+bus_detail_1['14']+bus_detail_2['14']+bus_detail_3['14']+bus_detail_4['14']+bus_detail_5['14']+bus_detail_6['14']
	total_busno['15']=bus_detail['15']+bus_detail_1['15']+bus_detail_2['15']+bus_detail_3['15']+bus_detail_4['15']+bus_detail_5['15']+bus_detail_6['15']

	//------------------------------------------------------------------------------------------------------------------------------------------------------


	const metro_monday= await db.collection('metro').doc('monday').get()
	metro1=metro_monday.data()
	
	
	

	
	

	total_metro['monday']=metro1['red']+metro1['yellow']+metro1['blue']+metro1['green']+metro1['violet']+metro1['orange']+metro1['magenta']+metro1['pink']

	const metro_tuesday= await db.collection('metro').doc('tuesday').get()
	metro2=metro_tuesday.data()
	
	

	total_metro['tuesday']=metro2['red']+metro2['yellow']+metro2['blue']+metro2['green']+metro2['violet']+metro2['orange']+metro2['magenta']+metro2['pink']


	const metro_wednesday= await db.collection('metro').doc('wednesday').get()
	metro3=metro_wednesday.data()
	
	

	total_metro['wednesday']=metro3['red']+metro3['yellow']+metro3['blue']+metro3['green']+metro3['violet']+metro3['orange']+metro3['magenta']+metro3['pink']


	const metro_thursday= await db.collection('metro').doc('thursday').get()
	metro4=metro_thursday.data()
	

	total_metro['thursday']=metro4['red']+metro4['yellow']+metro4['blue']+metro4['green']+metro4['violet']+metro4['orange']+metro4['magenta']+metro4['pink']


	const metro_friday= await db.collection('metro').doc('friday').get()
	metro5=metro_friday.data()
	
	

	total_metro['friday']=metro5['red']+metro5['yellow']+metro5['blue']+metro5['green']+metro5['violet']+metro5['orange']+metro5['magenta']+metro5['pink']


	const metro_saturday= await db.collection('metro').doc('saturday').get()
	metro6=metro_saturday.data()
	

	total_metro['saturday']=metro6['red']+metro6['yellow']+metro6['blue']+metro6['green']+metro6['violet']+metro6['orange']+metro6['magenta']+metro6['pink']


	const metro_sunday= await db.collection('metro').doc('sunday').get()
	metro7=metro_sunday.data()
	

	total_metro['sunday']=metro7['red']+metro7['yellow']+metro7['blue']+metro7['green']+metro7['violet']+metro7['orange']+metro7['magenta']+metro7['pink']

	total_metroline['red']=metro1['red']+metro2['red']+metro3['red']+metro4['red']+metro5['red']+metro6['red']+metro7['red']
	total_metroline['yellow']=metro1['yellow']+metro2['yellow']+metro3['yellow']+metro4['yellow']+metro5['yellow']+metro6['yellow']+metro7['yellow']
	total_metroline['blue']=metro1['blue']+metro2['blue']+metro3['blue']+metro4['blue']+metro5['blue']+metro6['blue']+metro7['blue']
	total_metroline['green']=metro1['green']+metro2['green']+metro3['green']+metro4['green']+metro5['green']+metro6['green']+metro7['green']
	total_metroline['violet']=metro1['violet']+metro2['violet']+metro3['violet']+metro4['violet']+metro5['violet']+metro6['violet']+metro7['violet']
	total_metroline['orange']=metro1['orange']+metro2['orange']+metro3['orange']+metro4['orange']+metro5['orange']+metro6['orange']+metro7['orange']
	total_metroline['magenta']=metro1['magenta']+metro2['magenta']+metro3['magenta']+metro4['magenta']+metro5['magenta']+metro6['magenta']+metro7['magenta']
	total_metroline['pink']=metro1['pink']+metro2['pink']+metro3['pink']+metro4['pink']+metro5['pink']+metro6['pink']+metro7['pink']

	

	data['total_bus']=total_bus
	data['total_busno']=total_busno
	data['total_metro']=total_metro
	data['total_metroline']=total_metroline
	data['usage']=usage_detail

	return data

}
loadData()







//---------------------------------------------------------------------------------------

router.get('/',function(req,res){
	res.setHeader('Content-type','text/html')
	res.sendFile(path.join(__dirname+'/res/index.html'));
})
router.get('/analysis',function(req,res){
	res.setHeader('Content-type','text/html')
	async function ren(){
		s=await loadData()
		
		await res.render(__dirname+'/res/analysis.ejs',{ 
			data:JSON.stringify(s)
		})
	}
	ren()
})
router.post('/check',urlencodedParser, function(req, res){
   console.log(req.body);
   const result=check.check(req.body.aadhar)
   console.log(result[0])
   res.render(path.join(__dirname+'/res/out.ejs'),{
   	data:req.body,
   	day1:result[0],
   	day2:result[1],
   	day3:result[2]
   });
});

router.post('/contact',urlencodedParser,function(req,res){
   const smtpTrans=nodemailer.createTransport({
      host: 'smtp.gmail.com',
      port:465,
      secure:true,
      auth:{
         user:'fromwebsite0@gmail.com',
         pass:'hackchennai2020'
      }
   })
   const mailOpts = {
    from: 'Our Website', 
    to: 'fromwebsite0@gmail.com',
    subject: `New message from contact form says ${req.body.subject}`,
    text: `${req.body.name} (${req.body.email}) says: ${req.body.message}`
  }
  smtpTrans.sendMail(mailOpts, (error, response) => {
    if (error) {
      res.end('contact-failure') 
    }
    else {
      res.redirect(req.get('referer')) 
    }
  })

})

app.use('/',router);
app.listen(process.env.PORT || 8080)