const Sequelize = require('sequelize')

// const database = (database, username, password, config) => {
//   let options = config
//     ? {
//         host: 'localhost',
//         port: '3306',
//         dialect: 'mysql',
//         pool: {
//           maxConnections: 20,
//           minConnections: 0,
//           maxIdleTime: 10000
//         },
//         retry: {
//           max: 5
//         },
//         replication: false
//       }
//     : config
//   return new Sequelize(database, username, password, options)
// }

const config = {
  host: 'localhost',
  port: '3306',
  dialect: 'mysql',
  pool: {
    maxConnections: 20,
    minConnections: 0,
    maxIdleTime: 10000
  },
  retry: {
    max: 5
  },
  replication: false
}

const sequelize = new Sequelize('mac_building', 'root', 'root', config)

module.exports = sequelize
