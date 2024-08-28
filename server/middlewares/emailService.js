const nodemailer = require('nodemailer');

// Create a transporter object using your email service provider
const transporter = nodemailer.createTransport({
  service: 'gmail', // or your email service provider
  auth: {
    user: 'your-email@gmail.com',
    pass: 'your-email-password',
  },
});

const sendEmail = async (to, subject, text) => {
  try {
    const info = await transporter.sendMail({
      from: 'your-email@gmail.com',
      to,
      subject,
      text,
    });
    console.log('Email sent:', info.response);
  } catch (error) {
    console.error('Error sending email:', error);
  }
};

module.exports = sendEmail;
