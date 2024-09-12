import React from 'react';
import { IonButton, IonCard, IonCardContent, IonGrid, IonRow, IonCol, IonInput, IonTextarea } from '@ionic/react';
import { Carousel } from 'react-responsive-carousel';

// Rainbow colors
const rainbowColors = [
  '#FF0000', // Red
  '#FF7F00', // Orange
  '#FFFF00', // Yellow
  '#00FF00', // Green
  '#0000FF', // Blue
  '#4B0082', // Indigo
  '#9400D3'  // Violet
];

// Reusable Section component
const Section = ({ color, children }) => (
  <div style={{ backgroundColor: color, padding: '40px 20px', color: 'white' }}>
    {children}
  </div>
);

const HeroSection = () => (
  <Section color={rainbowColors[0]}>
    <h1>ClickVeras Tech: Soluções Digitais que Transformam Negócios</h1>
    <h2>Desenvolvemos sites, aplicativos e chatbots inovadores para impulsionar o seu sucesso!</h2>
    <IonButton href="#contact" color="light">Fale Conosco</IonButton>
    <IonButton href="#projects" color="light">Veja Nossos Projetos</IonButton>
  </Section>
);

const WebDevSection = () => (
  <Section color={rainbowColors[1]}>
    <h2>Desenvolvimento Web</h2>
    <p>Sites e sistemas web incríveis com Laravel e React, desenvolvidos para o sucesso do seu negócio.</p>
    <Carousel showArrows={true} showThumbs={false}>
      <div>
        <img src="/api/placeholder/400/300" alt="Landing Page 1" />
        <p className="legend">Landing Page 1</p>
      </div>
      <div>
        <img src="/api/placeholder/400/300" alt="Landing Page 2" />
        <p className="legend">Landing Page 2</p>
      </div>
      <div>
        <img src="/api/placeholder/400/300" alt="Landing Page 3" />
        <p className="legend">Landing Page 3</p>
      </div>
    </Carousel>
  </Section>
);

const MobileDevSection = () => (
  <Section color={rainbowColors[2]}>
    <h2>Desenvolvimento Mobile</h2>
    <p>Apps em Flutter que parecem dançar no ritmo do seu negócio, proporcionando uma experiência de usuário espetacular.</p>
    <IonGrid>
      <IonRow>
        {['Chatbot Delivery', 'Agendamento Petshop', 'Agendamento Médico'].map((app, index) => (
          <IonCol key={index}>
            <IonCard>
              <IonCardContent>
                <img src={`/api/placeholder/100/100`} alt={app} />
                <p>{app}</p>
              </IonCardContent>
            </IonCard>
          </IonCol>
        ))}
      </IonRow>
    </IonGrid>
  </Section>
);

const ChatbotsSection = () => (
  <Section color={rainbowColors[3]}>
    <h2>Chatbots Inteligentes</h2>
    <p>Automatize o atendimento, agende compromissos e aumente a eficiência com chatbots poderosos para WhatsApp.</p>
    <IonGrid>
      <IonRow>
        {['Chatbot Delivery', 'Agendamento Petshop', 'Agendamento Médico'].map((bot, index) => (
          <IonCol key={index}>
            <IonCard>
              <IonCardContent>
                <img src={`/api/placeholder/100/100`} alt={bot} />
                <p>{bot}</p>
              </IonCardContent>
            </IonCard>
          </IonCol>
        ))}
      </IonRow>
    </IonGrid>
  </Section>
);

const PortfolioSection = () => (
  <Section color={rainbowColors[4]}>
    <h2>Conheça Nossos Projetos</h2>
    <Carousel showArrows={true} showThumbs={false}>
      {[1, 2, 3].map((project) => (
        <div key={project}>
          <img src={`/api/placeholder/800/600`} alt={`Projeto ${project}`} />
          <p className="legend">Projeto {project}</p>
        </div>
      ))}
    </Carousel>
  </Section>
);

const TestimonialsSection = () => (
  <Section color={rainbowColors[5]}>
    <h2>Depoimentos de Clientes</h2>
    <blockquote>"A ClickVeras Tech transformou nosso negócio com soluções inovadoras!" - Cliente A</blockquote>
    <blockquote>"Profissionalismo e qualidade incomparáveis. Recomendo!" - Cliente B</blockquote>
  </Section>
);

const ContactSection = () => (
  <Section color={rainbowColors[6]}>
    <h2>Pronto para a Revolução Tecnológica?</h2>
    <IonButton color="light">Fale Conosco</IonButton>
    <form>
      <IonGrid>
        <IonRow>
          <IonCol>
            <IonInput label="Nome" type="text" placeholder="Seu nome" required></IonInput>
          </IonCol>
          <IonCol>
            <IonInput label="E-mail" type="email" placeholder="seu@email.com" required></IonInput>
          </IonCol>
        </IonRow>
        <IonRow>
          <IonCol>
            <IonInput label="Telefone" type="tel" placeholder="(00) 00000-0000"></IonInput>
          </IonCol>
        </IonRow>
        <IonRow>
          <IonCol>
            <IonTextarea label="Mensagem" placeholder="Como podemos ajudar?" required></IonTextarea>
          </IonCol>
        </IonRow>
        <IonRow>
          <IonCol>
            <IonButton type="submit" color="light">Enviar</IonButton>
          </IonCol>
        </IonRow>
      </IonGrid>
    </form>
  </Section>
);

const App = () => (
  <div className="landing-page">
    <HeroSection />
    <WebDevSection />
    <MobileDevSection />
    <ChatbotsSection />
    <PortfolioSection />
    <TestimonialsSection />
    <ContactSection />
  </div>
);

export default App;