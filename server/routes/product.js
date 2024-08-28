const express = require("express");
const productRouter = express.Router();

const {Product} = require("../models/product");

//get the middleware of auth 
const auth = require('../middlewares/auth');



//creating a body in the api because it not a get request 
//and the url supposed to be api/products?shop=centerpoint from the client side 





//get all the products 
productRouter.get('/api/products', auth, async (req, res) => {

    try
    {
        console.log(req.query.shopName);


      const products = await Product.find({shopName: req.query.shopName});
      res.json(products);


    }
    catch(e)
    {
      res.status(500).json({error: e.message})

    }

  });


  //create a get request to search prducts and get them

  productRouter.get('/api/products/search/:name', auth, async (req, res) => {

    try
    {
        console.log(req.params.name);


      const products = await Product.find({name: {$regex: req.params.name, $options: "i"}});
      res.json(products);


    }
    catch(e)
    {
      res.status(500).json({error: e.message})

    }

  });


  //creating a post request route to rate the products
  productRouter.post('/api/rate-product', auth, async (req, res) => {
    try{
      const {id, rating} = req.body;
      let product = await Product.findById(id);

      for(let i = 0; i < product.ratings.length; i++)
      {
        if(product.ratings[i].userId == req.userId)
        {
          product.ratings.splice(i, 1);
          break;
        }
      }

      const ratingSchema = {
        userId: req.user,
        rating,
      };

      product.ratings.push(ratingSchema);
      product = await product.save();
      res.json(product);

    }
    catch(e)
    {
      res.status(500).json({error: e.message});
    }

  });




  module.exports = productRouter;