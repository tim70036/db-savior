const readline = require('readline');
const { knexClient } = require('./knexClient');

async function getProcessHistory (processId) {
    const result = await knexClient.select( 'ps.id', 'ps.user', 'ps.host', 'ps.db', 'th.thread_id', 'esh.sql_text')
                                    .from('information_schema.processlist AS ps')
                                    .leftJoin('performance_schema.threads AS th', 'th.processlist_id', 'ps.id')
                                    .leftJoin('performance_schema.events_statements_history AS esh', 'esh.thread_id', 'th.thread_id')
                                    .where('ps.id', processId)
                                    .orderBy('esh.EVENT_ID');
    return result.reduce((summary, row) => {
        if (!summary.processId) {
            summary = {
                processId: row.id,
                user: row.user,
                host: row.host,
                db: row.db,
                sqlHistory: [],
            }
        }
        summary.sqlHistory.push(row.sql_text);
        return summary;
    }, {});
}

async function saveProcessHistory (processHistory) {
    await knexClient('Log.KilledProcessHistory').insert({
        processId: processHistory.processId,
        user: processHistory.user,
        host: processHistory.host,
        db: processHistory.db,
        sqlHistory: JSON.stringify(processHistory.sqlHistory),
    });
}

const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const regex = /KILL ([0-9]+) /;

reader.on('line', async (input) => {
    try {
        const processId = Number.parseInt(input.match(regex)[1]);
        if (processId === NaN || processId === undefined)
            throw new Error(`processId[${processId}] cannot be parsed to integer`);
            
        console.log(`   Received: ${input}`);
        console.log(`   Getting process id[${processId}] sql history...`)
        const processHistory = await getProcessHistory(processId);
        await saveProcessHistory(processHistory);
        console.log(`   Process id[${processId}] history saved`)
    } catch (error) {
        console.log(error);
    }
});

reader.on('pause', () => {
    console.log('Readline paused.');
});

reader.on('resume', () => {
    console.log('Readline resumed.');
});
