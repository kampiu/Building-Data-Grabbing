const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const tagsModel = sequelize.define(
	'rea_tags',
	{
		id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true,
			autoIncrement: true
		},
		tags: {
			type: Sequelize.CHAR(20),
			allowNull: false
		},
		title: {
			type: Sequelize.CHAR(20),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = tagsModel
