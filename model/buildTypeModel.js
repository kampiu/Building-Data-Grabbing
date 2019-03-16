const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const BuildTypeModel = sequelize.define(
	'rea_building_house_type',
	{
		build_id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true,
		},
		house_type_id: {
			type: Sequelize.CHAR(20),
			primaryKey: true,
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = BuildTypeModel
