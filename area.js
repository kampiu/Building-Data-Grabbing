const http = require("http")
const fs = require("fs")
const cheerio = require("cheerio")
const request = require("request")
const iconv = require('iconv-lite')
const https = require("https")
const crypto = require('crypto')
const Sequelize = require('sequelize')
const sequelize = require('./sequelize')

let fileList = []
let fileIndex = 0
let fileLen = 0
let dataList = []
let dataIndex = 0
let dataLen = 0
let city = []
let parentId = null

const Area = sequelize.define(
	'rea_region',
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
		fullspell: {
			type: Sequelize.CHAR(50),
			allowNull: false
		},
		level: {
			type: Sequelize.INTEGER(3),
			allowNull: false
		},
		district_id: {
			type: Sequelize.INTEGER(11),
			allowNull: false
		},
		latitude: {
			type: Sequelize.CHAR(20),
			allowNull: false
		},
		longitude: {
			type: Sequelize.CHAR(30),
			allowNull: false
		},
		parent_level: {
			type: Sequelize.CHAR(3),
			allowNull: false
		}
	}, {
		underscored: true,
		timestamps: false,
		freezeTableName: true
	}
)

const start = () => {
	getFileList(() => {
		readData()
	})
}

const getFileList = callback => {
	fs.readdir('./data/', (err, files) => {
		if (err) {
			console.warn(err)
		} else {
			fileList = files
			fileLen = files.length
			callback()
		}
	});
}

const getData = () => {
	return new Promise((resolve, reject) => {
		fs.readFile(`./data/${fileList[fileIndex]}`, 'utf-8', (error, content) => {
			if(error){
				console.warn('获取文件stats失败', `./data/${fileList[fileIndex]}`);
				reject()
			}else{
				// 获取区域数组，处理父级区域
				// let content = fs.readFileSync(filedir, 'utf-8');
				console.log(fileList[fileIndex], typeof content)
				let kk = JSON.parse(content)
				let data = kk.data.nh_city_info
				let list = data.district
				let arr = []
				arr[0] = {
					name: data.city_name,
					fullspell: data.fullspell,
					level: 1,
					district_id: data.city_id,
					latitude: data.latitude,
					longitude: data.longitude,
					parent_level: ''
				}
				for(let i = 0,len = list.length;i < len;i++){
					arr.push({
						name: list[i].district_name,
						fullspell: list[i].quanpin,
						level: 2,
						district_id: list[i].district_id,
						latitude: list[i].latitude,
						longitude: list[i].longitude,
						parent_level: 1
					})
				}
				resolve(arr);
			}
		})
	})
}

const readData = callback => {
	getData().then(res => {
		dataList = res
		dataIndex = 0
		dataLen = dataList.length
		saveData(dataList[dataIndex])
		// 先获取父级ID，数组的第一个
		// console.log(res)
	}).catch(err => console.log(err))
}

const saveData = async data => {
	if (dataIndex === dataLen) {
		if(fileIndex === fileLen){
			console.log('全部数据添加完毕')
			return
		}
		fileIndex++
		getData().then(res => {
			dataList = res
			dataIndex = 0
			dataLen = dataList.length
			saveData(dataList[dataIndex])
			// console.log(res)
		}).catch(err => console.log(err))
		return
	}
	// console.log(data)
	if(dataIndex === 0){
        const article = await Area.create(data)
		parentId = article.dataValues.id
	}else{
	    data.parent_level = parentId
	    const article = await Area.create(data)
	}

	// console.log('adadss', article.dataValues.id)
	dataIndex++
	saveData(dataList[dataIndex])
}


start()










