const Sequelize=require('sequelize');
const db=new Sequelize(
    'beymart','root','yeshimysql',{
        dialect:'mysql',
        host:'localhost'
    }
);
const ProductModel=db.define('product',{
    imageurl:{type:Sequelize.STRING},
    prince:{type:Sequelize.FLOAT},
    titile:{type:Sequelize.STRING},
    description:{type:Sequelize.STRING}
});
db.sync({force:true}).then(()=>{
  __dirname.times(10,()=>{
    return ProductModel.create({
        imageurl:casual.imageurl,
        price:casual.prince,
        title:casual.price,
        description:casual.description
    })
  })  
})
const Product=db.models.product;
module.exports={Product}