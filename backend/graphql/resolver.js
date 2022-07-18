const {
    product
  } = require('../models');
  
  const Query = {
    getProducts: async(root)=>{
      try {
        const products=await product.findAll();
        return products;
      } catch (err) {
        console.log(err);
      }
    },
    getProduct:async(root,{id})=>{
      try {
        const pro=await product.findOne(id);
        return pro;
      } catch (err) {
        console.log(err);
      }
    },
    
  }
  
  const Mutation = {
   
    createProduct:async(root,{
      title,
      description,
      imageUrl,
      price})=>{
        try {
          await product.create({
            title,
            description,
            imageUrl,
            price})
            return "Product created successfully"
        } catch (err) {
          console.log(err);
        }
       
    },
    updateProduct:async (root, {
      id,
      title,
      description,
      price,
    }) => {
      try {
        await  product&&product.update({
          title,
          description,
          price,
        }, { where: { id: id } });
        return "product updated successfully";
      } catch (err) {
        console.log(err)
      }
    },
    deleteProduct: async (root, { id }) => {
      await product.destroy({ where: { id: id } })
      return "Product deleted successfully";
    },
   
  }
 
  module.exports = { Query, Mutation }