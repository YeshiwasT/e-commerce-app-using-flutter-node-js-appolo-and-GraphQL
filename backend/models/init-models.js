var DataTypes = require("sequelize").DataTypes;
var _product=require("./product");

function initModels(sequelize) {
  var product=_product(sequelize,DataTypes);

  return {
    product,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;