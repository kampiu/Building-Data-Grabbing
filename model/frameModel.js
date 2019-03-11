const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

const FrameModel = sequelize.define(
	'rea_frame',
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
		project_name: {
			type: Sequelize.CHAR(30),
			allowNull: false
		},
		building_id: {
			type: Sequelize.BIGINT(30),
			allowNull: false
		},
		bedroom_count: {
			type: Sequelize.INTEGER(6),
			allowNull: false
		},
		parlor_count: {
			type: Sequelize.INTEGER(6),
			allowNull: false
		},
		cookroom_count: {
			type: Sequelize.INTEGER(6),
			allowNull: false
		},
		build_area: {
			type: Sequelize.INTEGER(6),
			allowNull: false
		},
		toilet_count: {
			type: Sequelize.INTEGER(6),
			allowNull: false
		},
		price: {
			type: Sequelize.BIGINT(20),
			allowNull: false
		},
		image_url: {
			type: Sequelize.CHAR(300),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

module.exports = FrameModel
