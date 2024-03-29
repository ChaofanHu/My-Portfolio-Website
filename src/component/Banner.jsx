import React from 'react'
import { Container, Row, Col } from 'react-bootstrap'
import {ArrowRightCircle} from 'react-bootstrap-icons'
import headerImg from '../assets/img/header-img.svg'
import { useEffect, useState } from 'react'
import { HashLink } from 'react-router-hash-link';
import { BrowserRouter } from 'react-router-dom'


function Banner() {

    const [loopNum, setLoopNum] = useState(0);
    const [isDeleting, setIsDeleting] = useState(false);
    const [text, setText] = useState('');
    const [delta, setDelta] = useState(300 - Math.random() * 100);
    const [index, setIndex] = useState(1);
    const toRotate = [ "Web Developer", "Data Scientist", "Backend Developer", "Full Stack Developer"];
    const period = 2000;
  
    useEffect(() => {
      let ticker = setInterval(() => {
        tick();
      }, delta);
  
      return () => { clearInterval(ticker) };
    }, [text])
  
    const tick = () => {
      let i = loopNum % toRotate.length;
      let fullText = toRotate[i];
      let updatedText = isDeleting ? fullText.substring(0, text.length - 1) : fullText.substring(0, text.length + 1);
  
      setText(updatedText);
  
      if (isDeleting) {
        setDelta(prevDelta => prevDelta / 2);
      }
  
      if (!isDeleting && updatedText === fullText) {
        setIsDeleting(true);
        setIndex(prevIndex => prevIndex - 1);
        setDelta(period);
      } else if (isDeleting && updatedText === '') {
        setIsDeleting(false);
        setLoopNum(loopNum + 1);
        setIndex(1);
        setDelta(500);
      } else {
        setIndex(prevIndex => prevIndex + 1);
      }
    }


  return (
    <BrowserRouter>
    <section className='banner' id='home'>
        <Container>
            <Row className='align-items-center'>
                <Col xs={12} md={6} xl={7}>
                  <span className="tagline">Welcome to my Portfolio</span>
                  <h1>{`Hi! I'm Chaofan`} <span className="txt-rotate" dataperiod="1000" data-rotate='[ "Web Developer", "Web Designer", "UI/UX Designer" ]'><span className="wrap">{text}</span></span></h1>
                  <p>I am a student currently pursuing a degree in informatics. My passion lies in the world of programming, where I find joy in solving complex problems and creating innovative solutions. I am fascinated by the ever-evolving landscape of technology and its potential to make a positive impact on the world.</p>
                  <HashLink to="#contact">
                  <button >Let’s Connect <ArrowRightCircle size={25} /></button>
                  </HashLink>
                </Col>
                <Col xs={12} md={6} xl={5}>
                    <img src={headerImg} alt="Header Image" />
                </Col>
            </Row>
        </Container>
    </section>
    </BrowserRouter>
  )

}

export default Banner