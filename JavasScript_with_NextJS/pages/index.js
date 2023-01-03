import Link from 'next/link'
import { serverFEATURE } from '../constants'

export async function getServerSideProps ({ query }) {
  const serverUserKey = query.serverUserKey || 'anonymous'
  const splitServerClient = require('../server/getServerSideSplitClient').default
  await splitServerClient.ready()
  const serverTreatment = splitServerClient.getTreatment(serverUserKey, serverFEATURE)
  console.log(`treatment '${serverTreatment}' for feature '${serverFEATURE}' and user key '${serverUserKey}'`)
  return { props: { serverTreatment, serverUserKey } }
};

export default function Index (props, { serverTreatment, serverUserKey }) {
  console.log(props)
  return (
    <div>
      <h1>Hello Next.js</h1>
      <p>Server Side Treatment '{props.serverTreatment}' for feature '{serverFEATURE}' and key '{props.serverUserKey}' </p>
      <p>Client Side Treatment '{props.isReady? props.clientTreatment: 'SDK Not Ready'}' for feature '{props.splitName}' and key '{props.userKey}' </p>
      <Link href='/about'>
        <a>About Page</a>
      </Link>
    </div>
  );
};
