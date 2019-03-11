
const fixInteger  = (num, n) => (Array(n).join(0) + num).slice(-n);

const dateFormat = time => {
	const date = new Date(time)
	return `${date.getFullYear()}-${fixInteger(date.getMonth()+1, 2)}-${fixInteger(date.getDate(), 2)}`
};

const getTimestamps = () => parseInt(new Date().getTime()/1000);

module.exports = {
	dateFormat,
	getTimestamps,
	fixInteger
}
