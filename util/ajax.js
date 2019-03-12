const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('../model/sequelize')
const { dateFormat, getTimestamps, fixInteger } = require('./tool')

const getData = ( requestData = { url: ''} ) => {
	let options = Object.assign({
		method: 'GET'
	}, requestData)

	return new Promise((resolve, reject) => {
		request(options, (error, response, body) => {
			if (!error && response.statusCode == 200) {
				resolve(body)
			}else{
				reject({err: error, msg: '请求失败 -> 请检查请求是否正确'})
			}
		})
	})
}

module.exports = {
	getData
}

