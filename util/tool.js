
const fixInteger  = (num, n) => (Array(n).join(0) + num).slice(-n);

const dateFormat = time => {
	const date = new Date(time)
	return `${date.getFullYear()}-${fixInteger(date.getMonth()+1, 2)}-${fixInteger(date.getDate(), 2)}`
};

const getTimestamps = () => parseInt(new Date().getTime()/1000);

const random = (min, max) => Math.floor(Math.random() * (max - min + 1) ) + min

const randomStr = count => {
	let str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
		result = ""
	while(count--) {
		result += str[random(0, str.length - 1)]
	}
	return result
}

module.exports = {
	dateFormat,
	getTimestamps,
	fixInteger,
	random,
	randomStr
}
