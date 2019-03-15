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
const { getData, downloadImg, getHouseDetail } = require('./util/ajax')
// 导入数据模型
const AreaModel = require('./model/areaModel')
const BuildModel = require('./model/buildModel')
const FrameModel = require('./model/frameModel')
const TagsModel = require('./model/tagsModel')
// 建立模型的关系
// 建立一对多的模型关系  foreignKey 为定义表的外键    targetKey 为被关联的表的外键
BuildModel.hasMany(FrameModel, { foreignKey: 'id', targetKey: 'building_id' });
FrameModel.belongsTo(BuildModel, { foreignKey: 'building_id',targetKey: 'id' });
// const City = sequelize.define('city', { countryCode: Sequelize.STRING });
// const Country = sequelize.define('country', { isoCode: Sequelize.STRING });
// Country.hasMany(City, {foreignKey: 'countryCode', sourceKey: 'isoCode'});
// City.belongsTo(Country, {foreignKey: 'countryCode', targetKey: 'isoCode'});
// 初始化抓取数据的信息
let cityList = [310000, 441900, 442000, 440600, 469029, 110000, 320100, 350200, 532900, 210200, 120000, 442000, 370101, 210100, 330100, 440300, 440400, 320500, 500000, 430100, ];
let cityIndex = 0;
let cityLen = cityList.length;
let cityId = 441900;        // => 需要抓取城市的ID
let page = 0;               // => 分页
let limit = 20;             // => 分页中的每一页的数量
let canLoad = true
// 获取到的数据信息
let buildList = []
let buildLen = 0
let buildIndex = 0

const getBuildList = () => {
	let Url = `http://app.api.lianjia.com/newhouse/app/feed/index?city_id=${cityList[cityIndex]}&has_filter=0&limit_count=${limit}&page=${page}&request_ts=${getTimestamps()}`
	getData({
		url: Url,
		method: "GET",
		json: true
	}).then(res => {
		// console.log('获取到的数据', res)
		buildList = res.data.resblock_list.list
		buildLen = buildList.length
		buildIndex = 0
		// 做数据边界判断 是否有page下一页
		if(buildLen < limit){
			canLoad = false
		}
		// 每次抓取完第一页就重置build参数
		start(buildList[buildIndex])
	}).catch(err => {
		console.log(`获取楼盘列表信息出错`, err)
	})
}

const start = async (param) => {
	if(buildLen === buildIndex){        // 判断楼盘下标边界
		page++
		if(canLoad){                    // 判断单个城市下的楼盘数量抓取边界
			getBuildList()
			return
		}else{
			cityIndex++
			if(cityIndex === cityLen){      // 判断单个城市抓取完毕边界
				return console.log('抓取完一页数据')
			}else{
				canLoad = true
				page = 0
				getBuildList()
				return
			}
		}
	}
	let data = param
	downloadImg(data.preload_detail_image[0].image_size_url).then(async imgResult => {
		console.log(imgResult)
		let insertData = {
			name: data.title,
			city_id: data.city_id,
			area_id: data.district_id,
			banner: imgResult.imgUrl,
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
		const build = await BuildModel.create(insertData);
		let buildId = build.dataValues.id;
		// console.log(`获取楼盘添加后返回的ID => ${buildId}, 正在抓取的城市ID为 => ${cityList[cityIndex]}`)
		getDetail({
			project_name: data.project_name,
			build_id: buildId
		}).then(res => {
			console.log('抓取详情页数据成功!!!!!!!!!!!!!')
			// buildIndex++
			// start(buildList[buildIndex])
		}).catch(err => {
			console.log()
		})
	}).catch(() => {
		console.log(`抓取图片失败, 放弃一条数据 ----------`)
	})
}

const getDetail = (OBJ) => {
	let Url = `http://app.api.lianjia.com/newhouse/app/resblock/detailv1?city_id=${cityList[cityIndex]}&page=1&preload=0&project_name=${OBJ.project_name}&request_ts=${getTimestamps()}`
	return new Promise((resolve, reject) => {
		getHouseDetail({
			url: Url,
			method: "GET",
			json: true
		}).then(async res => {
			// console.log(`返回的抓取到的详情页数据`, res, Url)
			let banner = res.data.data.header_img
			let bannerData = []
			for(let i = 0,len = banner.length;i < len;i++){
				await downloadImg(data.preload_detail_image[0].image_size_url).then(async imgResult => {
					console.log(imgResult.imgUrl)
					bannerData.push(imgResult.imgUr)
				}).catch(() => {
					console.log(`抓取楼盘的banner图片失败, 放弃一条数据 ----------`)
				})
			}
			let _frame = res.data.data['frame']
			for(let i = 0,len = _frame.length;i < len;i++) {
				await createFrame(_frame[i], OBJ.build_id)
			}
			resolve()
		}).catch(err => {
			reject()
			console.log('抓取错误，详情 -----------')
		})
	})
}

const createFrame = (_frameData, build_id) => {
	console.log(_frameData.images[0].image_url,'---------------')
	return new Promise((resolve, reject) => {
		// 户型的预览图 需要添加接口传来的图片高宽参数 => .宽x高.jpg
		let imgWidth = _frameData.images[0].src_img_size.width;
		let imgHeight = _frameData.images[0].src_img_size.height;
		let realImg = `${_frameData.images[0].image_url}.${imgWidth}x${imgHeight}.png`

		downloadImg(realImg).then( imgResult => {
			console.log(imgResult)
			let frameData = {
				name: _frameData.frame_name,
				project_name: _frameData.project_name,
				building_id: build_id,
				bedroom_count: _frameData.bedroom_count,
				parlor_count: _frameData.parlor_count,
				cookroom_count: _frameData.cookroom_count,
				toilet_count: _frameData.toilet_count,
				build_area: _frameData.build_area,
				price: _frameData.price,
				image_url: imgResult.imgUrl
			}
			FrameModel.create(frameData).then(() => {
				resolve()
			}).catch(() => {
				reject()
			});
			resolve()
		}).catch(() => {
			console.log(`抓取图片失败, 放弃一条数据 ----------`)
			reject()
		})
	})
}

getBuildList()



