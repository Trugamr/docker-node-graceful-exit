import fastify from 'fastify'

const app = fastify({ logger: true })

app.get('/', async (request, reply) => {
  reply.send({ message: 'hello world' })
})

try {
  await app.listen({ port: 3000, host: '0.0.0.0' })
} catch(error) {
  app.log.error(error)
  process.exit(1)
}
