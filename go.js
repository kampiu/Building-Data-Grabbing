const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')

let page = 1,
	result = []

const start = () => {
	const _url = `https://dg.fang.ke.com/loupan/pg${page}/`

	return new Promise((resolve, reject) => {
		request({
			url: _url,
			method: "GET",
			json: true
		}, (error, response, body) => {
			console.log(response.statusCode, `正在抓取第${page}页楼盘信息`)
			if (!error && response.statusCode == 200) {
				const result = filter(body)
			} else {
				reject()
			}
		});
	})
}

const filter = data => {
	const $ = cheerio.load(data)
	// const result = []
	$(".resblock-list-wrapper > li").map((index, item) => {
		let _tab = []
		for (let i = 0, len = $(item).find(".resblock-name").eq(0).find("span").length; i < len; i++) {
			_tab.push($(item).find(".resblock-name").eq(0).find("span").eq(i).text())
		}
		result.push({
			icon: $(item).find("img").eq(0).attr("data-original"),
			key: getKey($(item).find(".resblock-img-wrapper").eq(0).attr("href")),
			name: $(item).find(".resblock-name > a").eq(0).text(),
			price: $(item).find(".resblock-price .number").eq(0).text(),
			allprice: $(item).find(".resblock-price .second").eq(0).text(),
			area: ($(item).find(".resblock-location").eq(0).text()).replace(/(^\s*)|(\s*$)/g, ""),
			location: ($(item).find(".resblock-location").eq(0).text()).replace(/(^\s*)|(\s*$)/g, ""),
			tab: _tab
		})
	})
	if (page === 42) {
		saveJson(JSON.stringify(result))
	} else {
		page++
		start()
	}
}

const getKey = key => {
	let str = key.replace("/loupan/", "")
	return str.slice(0, str.length - 1)
}


const saveJson = (data) => {
	fs.writeFile(`./data/page_all.json`, data, 'utf8', (error) => {
		if (error) {
			console.log('下载失败')
			return
		}
		if (page === 43) {
			console.log("获取所有页面楼盘数据成功!")
			return
		}
		page++
		start()
	})
}

start()