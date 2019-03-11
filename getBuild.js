const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./model/sequelize')
// 导入工具类
const { dateFormat, getTimestamps, fixInteger } = require('./util/tool')
const { getData } = require('./util/ajax')
// 导入数据模型
const AreaModel = require('./model/areaModel')
const BuildModel = require('./model/buildModel')
const FrameModel = require('./model/frameModel')
const TagsModel = require('./model/tagsModel')

// 建立模型的关系
// 建立一对多的模型关系  foreignKey 为定义表的外键    targetKey 为被关联的表的外键
BuildModel.hasMany(FrameModel, { foreignKey: 'id', targetKey: 'building_id' });
FrameModel.belongsTo(BuildModel, { foreignKey: 'building_id',targetKey: 'id' });
// console.log(AreaModel, BuildModel, FrameModel, TagsModel)
// const City = sequelize.define('city', { countryCode: Sequelize.STRING });
// const Country = sequelize.define('country', { isoCode: Sequelize.STRING });
//
// Country.hasMany(City, {foreignKey: 'countryCode', sourceKey: 'isoCode'});
// City.belongsTo(Country, {foreignKey: 'countryCode', targetKey: 'isoCode'});
// 初始化抓取数据的信息
let cityId = 441900;        // => 需要抓取城市的ID
let page = 0;               // => 分页
let limit = 20;             // => 分页中的每一页的数量
// 获取到的数据信息

const getBuildList = () => {
	let Url = `http://app.api.lianjia.com/newhouse/app/feed/index?city_id=${cityId}&has_filter=0&limit_count=${limit}&page=${page}&request_ts=${getTimestamps}`
	getData({
		url: Url,
		method: "POST",
		json: true,
		headers: {
			"content-type": "application/json",
		},
		body: JSON.stringify(requestData)
	})
}


const start = (param) => {
	let data = param
	let insertData = {
		name: data.title,
		city_id: data.city_id,
		area_id: data.district_id,
		banner: data.preload_detail_image[0].image_size_url,
		opening_time: dateFormat(data.on_time),                         // 时间过滤格式化 YY/MM/DD
		address: data.address,
		coor: `${data.longitude},${data.latitude}`,
		average_price: data.average_price,
		project_name: data.project_name,
		build_id: data.build_id,
		min_frame_area: data.min_frame_area,
		max_frame_area: data.max_frame_area,
		house_type: data.house_type,        // 多对多关系模型  =>   房子类型  [办公楼，住宅]
		decoration: data.decoration         // 多对多关系模型  =>   装修类型  [毛坯，精装]
	}
}


start()



