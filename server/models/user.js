const mongoose = require('mongoose');
const { productSchema } = require('./product');

const shopUsersSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,


    },
    crNumber: {
        required: true,
        type: String,
        trim:true,
        validate: {
            validator: (value) => {
               return value.length <= 7;
            },
            message: 'Please write a correct CR ',
        },
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
            },
            message: 'Please  enter a valid email address'
        },
    },

    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
               return value.length >= 8;
            },
            message: 'Password is too weak please use more then 8 characters'
        },
    },
    phoneNumber: {
        type: String,
        required: true,
        validate: {
          validator: function(v) {
            // Simple regex for validating phone numbers 
            return /\+?[0-9\s-]{7,15}/.test(v);
          },
          message: props => `${props.value} is not a valid phone number!`
        }
      },

      status: {
        type: Boolean,
        required: true,
        
      },
   
    

    

    
});

const shopUser = mongoose.model("shopUsers", shopUsersSchema);
module.exports = shopUser;