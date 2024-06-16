require("dotenv").config()
const express = require('express')
const cors = require('cors')
const nodemailer = require('nodemailer')



const router = express.Router()
const app = express();

app.use(cors());
app.use(express.json())
app.use('/', router)
app.listen(8080, ()=> console.log('server start'))

const contactEmail = nodemailer.createTransport({
    service:'outlook',
    auth:{
        user: process.env.OUTLOOK_USER,
        pass: process.env.OUTLOOK_PASS
    }
});

contactEmail.verify((error) => {
    if (error) {
        console.log(error);
    } else {
        console.log('Ready to Send');
    }
});


router.post('/contact', (req,res) =>{
    const name = req.body.firstName + req.body.lastName;
    const email = req.body.email;
    const phone = req.body.phone;
    const message = req.body.message;
    const mail = {
        from: name,
        to: 'hu.chaofan@outlook.com',
        subject: 'New Message from Contact Form',
        html: `<p>Name: ${name}</p>
               <p>Email: ${email}</p>
               <p>Phone: ${phone}</p>
               <p>Message: ${message}</p>`,
    };
    contactEmail.sendMail(mail, (error)=>{
      if(error){
        res.json(error);
      }  else{
        res.json({code: 200, status: 'Message Sent'});
      }
    })
})
