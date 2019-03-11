const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./model/sequelize')
const { dateFormat, getTimestamps, fixInteger } = require('./tool')

const getData = (optionsParam = {}) => {
	let options = Object.assign({
		city_id: 441900,
		has_filter: 0,
		limit_count: 20,
		page: 0,            // 分页从0开始 => 第一页
		request_ts: getTimestamps()
	}, optionsParam)

}

module.exports = {
	getData
}

