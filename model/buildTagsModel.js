const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const BuildTagsModel = sequelize.define(
	'rea_building_tags',
	{
		tags_id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true
		},
		build_id: {
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

module.exports = BuildTagsModel
