const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
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
		name: {
			type: Sequelize.CHAR(20),
			allowNull: false
		},
		name: {
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
