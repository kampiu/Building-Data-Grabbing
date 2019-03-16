const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const BuildModel = sequelize.define(
	'rea_building',
	{
		id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true,
			autoIncrement: true
		},
		name: {
			type: Sequelize.CHAR(50),
			allowNull: false
		},
		city_id: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		area_id: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		banner: {
			type: Sequelize.TEXT(),
			allowNull: false
		},
		opening_time: {
			type: Sequelize.DATE(),
			allowNull: false
		},
		address: {
			type: Sequelize.CHAR(3),
			allowNull: false
		},
		coor: {
			type: Sequelize.CHAR(60),
			allowNull: false
		},
		average_price: {
			type: Sequelize.INTEGER(10),
			allowNull: false
		},
		project_name: {
			type: Sequelize.CHAR(200),
			allowNull: false
		},
		build_id: {
			type: Sequelize.BIGINT(30),
			allowNull: false
		},
		min_frame_area: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		max_frame_area: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		house_type: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		decoration: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = BuildModel
