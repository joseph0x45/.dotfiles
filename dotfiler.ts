const server = Bun.serve({
    port: 8080,
    async fetch(req){
        const req_url = new URL(req.url)
        if(req_url.pathname==="/nvim"){
            return new Response(Bun.file("./scripts/nvim.sh"))
        }
	if(req_url.pathname==="/get_nvim){
    		return new Response(Bun.file("./assets/nvim.zip"))
    	}
        return new Response("")
    }
})

console.log(`Server alive on ${server.hostname}:${server.port}`)
