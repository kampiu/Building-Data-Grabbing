
const start = async () => {
	for(let i = 0;i < 9;i++){
		await setTimeout(async () => {
			await console.log(i)
		},1000)
	}
}

start()
