import fastify from 'fastify'

const app = fastify({ logger: true })

// Routes 
app.get('/', async (request, reply) => {
  reply.send({ message: 'hello world' })
})

// Start the server
try {
  await app.listen({ port: 3000, host: '0.0.0.0' })
} catch(error) {
  app.log.error(error)
  process.exit(1)
}

// Graceful shutdown
process.on('SIGTERM', async () => {
  app.log.info('Got SIGTERM. Graceful shutdown start...')
  await app.close()
  process.exit(0)
})