const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const db = require('./config.js')

let page = 0,
	allB = [],
	count = 0

const getBuild = () => {
	fs.readFile(`./data/page_all.json`, {
			encoding: "utf-8"
		},
		function (error, result) {
			if (error) {
				console.log('下载失败')
				return
			}
			allB = JSON.parse(result)
			count = allB.length - 1
			start()
		})
}

const start = () => {
	const _url = `https://dg.fang.ke.com/loupan/${allB[page].key}`

	request({
		url: _url,
		method: "GET",
		json: true
	}, (error, response, body) => {
		console.log(response.statusCode, `正在抓取第${page}页楼盘信息，楼盘ID为：${allB[page].key}，楼盘名字：${allB[page].name}`)
		if (!error && response.statusCode == 200) {
			filter(body)
		} else {

		}
	})
}

const filter = data => {
	const $ = cheerio.load(data)

	let _type = []
	if ($(".mod-panel-houseonline").eq(0).find(".house-det") && $(".mod-panel-houseonline").eq(0).find(".house-det").length > 0) {
		for (let i = 0, len = $(".mod-panel-houseonline").eq(0).find(".house-det").length; i < len; i++) {
			let target = $(".mod-panel-houseonline").eq(0).find(".house-det").eq(i)
			let _tab = []
			if (target.find(".p4").eq(0).find("span").length > 0) {
				for (let j = 0, lens = target.find(".p4").eq(0).find("span").length; j < lens; j++) {
					_tab.push(target.find(".p4").eq(0).find("span").eq(j).text())
				}
			}
			_type.push({
				house_icon: target.find(".img-li").eq(0).find("img").eq(0).attr("src"),
				house_title: target.find(".info-li").eq(0).find("p1").eq(0).text(),
				house_area: target.find(".info-li").eq(0).find("span").eq(0).text(),
				house_direction: target.find(".info-li").eq(0).find("span").eq(2).text(),
				house_price: target.find(".info-li > .p2").eq(0).find("span").eq(0).text(),
				house_describe: _tab
			})
		}
	}
	allB[page].area = filterArea(allB[page].location)
	allB[page].opening_time = filterDate($(".table-list > li").eq(0).find("span").eq(1).text())
	allB[page].developers = $(".box-loupan .desc-p").eq(3).find("span").eq(1).text()
	allB[page].company = $(".box-loupan .desc-p").eq(4).find("span").eq(1).text()
	allB[page].intersection_time = filterDate($(".table-list > li").eq(2).find("span").eq(1).text())
	allB[page].service_life = $(".table-list > li").eq(4).find("span").eq(1).text()
	allB[page].planned_user = $(".table-list > li").eq(6).find("span").eq(1).text()
	allB[page].property_cost = $(".table-list > li").eq(7).find("span").eq(1).text()
	allB[page].area_covered = ($(".table-list > li").eq(12).find("span").eq(1).text()).replace(/(^\s*)|(\s*$)/g, "")
	allB[page].builtUp_area = ($(".table-list > li").eq(13).find("span").eq(1).text()).replace(/(^\s*)|(\s*$)/g, "")
	allB[page].heating_mode = $(".table-list > div > li").eq(1).find("span").eq(1).text()
	allB[page].water_supply = $(".table-list > li").eq(8).find("span").eq(1).text()
	allB[page].power_supply = $(".table-list > li").eq(9).find("span").eq(1).text()
	allB[page].building_types = $(".table-list > li").eq(10).find("span").eq(1).text()
	allB[page].house_type = _type
	saveJson(JSON.stringify(allB))
}

const filterArea = area => {
	const index = area.indexOf("/")
	return area.slice(0, index)
}


const saveJson = (data) => {
	fs.writeFile(`./data/page_allss.json`, data, 'utf8', (error) => {
		if (error) {
			console.log('下载失败')
			return
		}
		if (page === count) {
			console.log("获取所有页面楼盘数据成功!")
			return
		}
		page++
		start()
	})
}

const filterDate = time => {
	time = time.slice(0, time.length - 1)
	time = time.replace("年", "/")
	return time.replace("月", "/")
}

// const saveDB = data => {
// 	let SQL = "INSERT INTO  `8kqw`.`8kqw_building` (
// 	`bu_id`,
// 	`bu_key`,
// 	`bu_icon`,
// 	`bu_name`,
// 	`bu_city`,
// 	`bu_region`,
// 	`bu_price`,
// 	`bu_opening_time`,
// 	`bu_location`,
// 	`bu_developers`,
// 	`bu_company`,
// 	`bu_intersection_time`,
// 	`bu_service_life`,
// 	`bu_planned_user`,
// 	`bu_property_cost`,
// 	`bu_area_covered`,
// 	`bu_builtUp_area`,
// 	`bu_parking_ratio`,
// 	`bu_heating_mode`,
// 	`bu_water_supply`,
// 	`bu_power_supply`,
// 	`bu_building_types`,
// 	`bu_house_type`
// 	)
// 	VALUES(
// 		NULL, '132313', '123131231', NULL, '131', '1323312', '131313', '2018-10-04 00:00:00', '13213', '13123', NULL, '0000-00-00 00:00:00', '123131', '1313', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
// 	);
// 	"
// 	db.query(SQL, function (error, rows) {
// 		if (error) {
// 			return console.log(error)
// 		}
// 		dataIndex++
// 		saveDB(list, dataIndex)
// 		console.log("插入数据库成功!!!__")
// 	})
// }


getBuild()