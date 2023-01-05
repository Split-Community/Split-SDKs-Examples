import Link from 'next/link'
import { serverFEATURE } from '../constants'

export default function About ({ treatment, userKey }) {
  return (
    <div>
      <p>This is the about page</p>
      <p>treatment '{treatment}' for feature '{serverFEATURE}' and user key '{userKey}' </p>
      <Link href='/'>
        <a>Go Back Home</a>
      </Link>
    </div>
  )
}

export async function getServerSideProps ({ query }) {
  const userKey = query.userKey || 'anonymous'
  console.log('SERVER SIDE ABOut')
  const splitClient = require('../server/getServerSideSplitClient').default
  await splitClient.ready()
  const treatment = splitClient.getTreatment(userKey, serverFEATURE)
  console.log(`treatment '${treatment}' for feature '${serverFEATURE}' and user key '${userKey}'`)
  return { props: { treatment, userKey } }
}
