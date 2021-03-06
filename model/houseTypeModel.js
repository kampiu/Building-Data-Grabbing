const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const HouseTypeModel = sequelize.define(
	'rea_house_type',
	{
		id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true,
			autoIncrement: true
		},
		name: {
			type: Sequelize.CHAR(20),
			allowNull: false
		},
		color: {
			type: Sequelize.CHAR(20),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = HouseTypeModel
