const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const HouseTypeModel = sequelize.define(
	'rea_region',
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
		fullspell: {
			type: Sequelize.CHAR(50),
			allowNull: false
		},
		level: {
			type: Sequelize.INTEGER(3),
			allowNull: false
		},
		district_id: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		latitude: {
			type: Sequelize.CHAR(20),
			allowNull: false
		},
		longitude: {
			type: Sequelize.CHAR(30),
			allowNull: false
		},
		parent_level: {
			type: Sequelize.CHAR(3),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = AreaModel
