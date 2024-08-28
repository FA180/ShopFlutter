const express = require('express');
const User = require('../models/user'); // Ensure this path is correct
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");
const shopUser = require('../models/user');
const authRouter = express.Router();

authRouter.get('/user', (req, res) => {
    res.json({ msg: 'Zahid' });
});

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, crNumber, email, password, phoneNumber, status } = req.body;
    console.log('Signup request received:', req.body); // Log incoming request

    const existingUser = await shopUser.findOne({ email });
    if (existingUser) {
      console.log('User with same email already exists:', email);
      return res.status(400).json({ msg: 'User with same email already exists!' });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    console.log('Password hashed successfully');

    let user = new shopUser({ email, password: hashedPassword, name, crNumber, phoneNumber, status });
    user = await user.save();
    console.log('User saved successfully:', user);

    res.json(user);
  } catch (e) {
    console.error('Error during signup:', e);
    res.status(500).json({ error: e.message });
  }
});



//sign in route 

authRouter.post("/api/signin", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      const user = await shopUser.findOne({ email });
      if (!user) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({ token, ...user._doc });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



  authRouter.post("/tokenIsValid", async (req, res) => {
    try {
  
    const token = req.header('x-auth-token');
    if(!token)return res.json(false);

   const verified = jwt.verify(token, 'passwordKey');
    if(!verified) return res.json(false);

    const user = await User.findById(verified.id);

    if(!user) return res.json(false);
    res.json(true);

    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


  //get user data api 
  authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  });

module.exports = authRouter; // Export the router
