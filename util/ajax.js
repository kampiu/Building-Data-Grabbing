const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('../model/sequelize')
const { dateFormat, getTimestamps, fixInteger, random, randomStr } = require('./tool')

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

const downloadImg = (image) => {
	return new Promise((resolve, reject) => {
		let imgObj = getImgType(image)
		let img = imgObj.url
		let imgType = imgObj.type === '' ? 'png' : imgObj.type
		// console.log(`抓取的图片路径为 => ${img}, ${image}`)
		http.get(img, (res) => {
			let imgData = ''
			res.setEncoding("binary")           //注意请求返回的编码
			res.on('data', (chunk) => {
				imgData += chunk
			})
			// 通过时间戳 + 盐后哈希获取图片名字
			const hash = crypto.createHash('md5');
			let str = randomStr(64);
			hash.update(str);
			let imgName = hash.digest('hex');

			res.on('end', () => {
				fs.writeFile("./imgData/" + imgName + "." + imgType, imgData, 'binary', (error) => {
					if(error) {
						console.log('下载失败')
						reject()
						return
					}
					resolve({
						imgUrl: `imgData/${imgName}.${imgType}`
					})
				})
			})
		})
	})
}

const getImgType = img => {
	// 首先获取图片的完整路径  =>  再强制转http
	try {
		let newImg = '';
		let type = '';
		// if(img.indexOf('.png') !== -1){
		// 	newImg = img.slice(0, img.indexOf('.png') + 4)
		// 	type = 'png'
		// }else if(img.indexOf('.jpg') !== -1){
		// 	newImg = img.slice(0, img.indexOf('.jpg') + 4)
		// 	type = 'jpg'
		// }else{
			newImg = img
		// }
		// 强制转http
		let _httpIndex = newImg.indexOf('://');
		newImg = newImg.slice(_httpIndex + 3, newImg.length)
		return {
			url: `http://${newImg}`,
			type: type
		}
	} catch(e) {
		console.log(`图片转路径失败!!! => Error`, e)
	}
}

// http://app.api.lianjia.com/newhouse/app/resblock/detailv1?city_id=441900&page=1&preload=0&project_name=kdwcbjjyd&request_ts=1551727720
const getHouseDetail = ( requestData = { url: ''} ) => {
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

const downloadImgs = (image) => {
	let imgObj = getImgType(image)
	let img = imgObj.url
	let imgType = imgObj.type === '' ? 'png' : imgObj.type
	// console.log(`抓取的图片路径为 => ${img}, ${image}`)
	http.get(img, (res) => {
		let imgData = ''
		res.setEncoding("binary")           //注意请求返回的编码
		res.on('data', (chunk) => {
			imgData += chunk
		})
		// 通过时间戳 + 盐后哈希获取图片名字
		const hash = crypto.createHash('md5');
		let str = randomStr(64);
		hash.update(str);
		let imgName = hash.digest('hex');

		res.on('end', () => {
			fs.writeFile("./imgData/" + imgName + "." + imgType, imgData, 'binary', (error) => {
				if(error) {
					console.log('下载失败')
					return
				}
				return {
					imgUrl: `imgData/${imgName}.${imgType}`
				}
			})
		})
	})
}

module.exports = {
	getData,
	downloadImg,
	getHouseDetail,
	downloadImgs
}

