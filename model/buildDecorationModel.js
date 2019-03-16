const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const BuildDecorationModel = sequelize.define(
	'rea_building_decoration',
	{
		build_id: {
			type: Sequelize.INTEGER(11),
			primaryKey: true,
			unique: true,
		},
		decoration_id: {
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

module.exports = BuildDecorationModel
