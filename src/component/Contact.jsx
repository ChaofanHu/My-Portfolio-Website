import React, { useState } from 'react'
import { Container, Row, Col } from 'react-bootstrap';
import contactImg from '../assets/img/contact-img.svg';

function Contact() {
    const formInitialData = {
        firstName:"",
        lastName:'',
        email:'',
        phone:'',
        message:''
    }
    const [formData, setFormData] = useState(formInitialData);
    const [buttonText, setButtonText] = useState('Send');
    //for show if send or not
    const [status, setStatus] = useState({});

    const onFormUpdate = (category, value) => {
        setFormData({
          ...formData,
          [category]: value
        })
    }

    const handlerSubmit = async (e) => {
        e.preventDefault();
        setButtonText('Sending...')
        let res = await fetch('http://localhost:8080/contact',{
            method: 'POST',
            headers:{
                "Content-Type": "application/json;charset=utf-8",
            },
            body: JSON.stringify(formData)
        });
        setButtonText('Sent!')
        let result = await res.json();
        setFormData(formInitialData);
        if(result.code == 200){
            setStatus({
                success:true,
                message:'Message sent successfully'
            })
        }else{
            setStatus({
                success:false,
                message:'Message not sent,please try again later'
            })
        }
    }

    return (
        <section className='contact' id='contact'>
            <Container>
                <Row className='align-items-center'>
                    <Col md={6}>
                    <img src={contactImg} alt="" />
                    </Col>
                    <Col md={6}>
                        <h2>Get In Touch</h2>
                        <form onSubmit={handlerSubmit} action="">
                            <Row>
                                <Col size={12} sm={6} className='px-1'>
                                    <input type="text" value={formData.firstName} placeholder="First Name" onChange={(e) => onFormUpdate('firstName', e.target.value)} />
                                </Col>
                                <Col size={12} sm={6} className='px-1'>
                                    <input type="text" value={formData.lastName} placeholder="Last Name" onChange={(e) => onFormUpdate('lastName', e.target.value)} />
                                </Col>
                                <Col size={12} sm={6} className='px-1'>
                                    <input type="text" value={formData.email} placeholder="Email" onChange={(e) => onFormUpdate('email', e.target.value)} />
                                </Col>
                                <Col size={12} sm={6} className='px-1'>
                                    <input type="text" value={formData.phone} placeholder="Phone Number" onChange={(e) => onFormUpdate('phone', e.target.value)} />
                                </Col>
                                <Col size={12} className='px-1'>
                                    <textarea rows="6" value={formData.message} placeholder="Message" onChange={(e) => onFormUpdate('message', e.target.value)}></textarea>
                                    <button type="submit"><span>{buttonText}</span></button>
                                </Col>
                                {
                                status.message &&
                                <Col>
                                    <p className={status.success === false ? "danger" : "success"}>{status.message}</p>
                                </Col>
                                }
                               
                            </Row>
                        </form>
                    </Col>
                </Row>
            </Container>
        </section>
    )
}

export default Contact