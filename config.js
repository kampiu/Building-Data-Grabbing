let db = {}
const mysql = require('mysql')
const pool = mysql.createPool({
	connectionLimit: 20,
	host: 'localhost',
	user: 'root',
	password: '',
	database: '8kqw',
	stringifyObjects: true,
	charset: 'UTF8'
});

db.query = function (sql, callback) {

	if (!sql) {
		callback()
		return
	}
	pool.query(sql, (err, rows) => {
		if (err) {
			console.log("MySQL_error:", err)
			callback(err, null)
			return;
		}

		callback(null, rows)
	})
}
module.exports = db