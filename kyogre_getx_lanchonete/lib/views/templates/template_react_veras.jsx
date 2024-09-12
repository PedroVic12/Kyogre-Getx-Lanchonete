import React from 'react';
import { IonButton, IonCard, IonCardContent, IonGrid, IonRow, IonCol, IonText } from '@ionic/react';
import { Carousel } from 'react-responsive-carousel';

const HeroSection = () => (
  <div className="hero">
    <h1>ClickVeras Tech: Soluções Digitais que Transformam Negócios</h1>
    <h2>Desenvolvemos sites, aplicativos e chatbots inovadores para impulsionar o seu sucesso!</h2>
    <IonButton href="#contact">Fale Conosco</IonButton>
    <IonButton href="#projects">Veja Nossos Projetos</IonButton>
  </div>
);

const ServicesSection = () => (
  <div id="services" className="section">
    <h2>Nossas Soluções</h2>
    <IonGrid>
      <IonRow>
        <IonCol>
          <IonCard>
            <IonCardContent>
              <h3>Desenvolvimento Web</h3>
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
            </IonCardContent>
          </IonCard>
        </IonCol>
        <IonCol>
          <IonCard>
            <IonCardContent>
              <h3>Desenvolvimento Mobile</h3>
              <p>Apps em Flutter que parecem dançar no ritmo do seu negócio, proporcionando uma experiência de usuário espetacular.</p>
              <IonGrid>
                <IonRow>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Chatbot Delivery" />
                        <IonText>Chatbot Delivery</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Agendamento Petshop" />
                        <IonText>Agendamento Petshop</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Agendamento Médico" />
                        <IonText>Agendamento Médico</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                </IonRow>
              </IonGrid>
            </IonCardContent>
          </IonCard>
        </IonCol>
        <IonCol>
          <IonCard>
            <IonCardContent>
              <h3>Chatbots Inteligentes</h3>
              <p>Automatize o atendimento, agende compromissos e aumente a eficiência com chatbots poderosos para WhatsApp.</p>
              <IonGrid>
                <IonRow>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Chatbot Delivery" />
                        <IonText>Chatbot Delivery</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Agendamento Petshop" />
                        <IonText>Agendamento Petshop</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                  <IonCol>
                    <IonCard>
                      <IonCardContent>
                        <img src="/api/placeholder/100/100" alt="Agendamento Médico" />
                        <IonText>Agendamento Médico</IonText>
                      </IonCardContent>
                    </IonCard>
                  </IonCol>
                </IonRow>
              </IonGrid>
            </IonCardContent>
          </IonCard>
        </IonCol>
      </IonRow>
    </IonGrid>
  </div>
);

const PortfolioSection = () => (
  <div id="projects" className="section">
    <h2>Conheça Nossos Projetos</h2>
    <Carousel showArrows={true} showThumbs={false}>
      <div>
        <img src="/api/placeholder/800/600" alt="Projeto 1" />
        <p className="legend">Projeto 1</p>
      </div>
      <div>
        <img src="/api/placeholder/800/600" alt="Projeto 2" />
        <p className="legend">Projeto 2</p>
      </div>
      <div>
        <img src="/api/placeholder/800/600" alt="Projeto 3" />
        <p className="legend">Projeto 3</p>
      </div>
    </Carousel>
    <div className="testimonials">
      <h3>Depoimentos de Clientes</h3>
      <blockquote>"A ClickVeras Tech transformou nosso negócio com soluções inovadoras!" - Cliente A</blockquote>
      <blockquote>"Profissionalismo e qualidade incomparáveis. Recomendo!" - Cliente B</blockquote>
    </div>
  </div>
);

const ContactSection = () => (
  <div id="contact" className="section">
    <h2>Pronto para a Revolução Tecnológica?</h2>
    <IonButton>Fale Conosco</IonButton>
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
            <IonButton type="submit">Enviar</IonButton>
          </IonCol>
        </IonRow>
      </IonGrid>
    </form>
  </div>
);

const App = () => (
  <div className="landing-page">
    <HeroSection />
    <ServicesSection />
    <PortfolioSection />
    <ContactSection />
  </div>
);

export default App;