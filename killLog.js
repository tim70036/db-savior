const readline = require('readline');
// const { knexClient } = require('./knexClient');


const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const regex = /KILL ([0-9]+) /;

reader.on('line', (input) => {
    try {
        const processId = Number.parseInt(input.match(regex)[1]);
        if (processId === NaN || processId === undefined)
            throw new Error(`processId[${processId}] cannot be parsed to integer`);

            
        console.log(`   Received: ${input}`);
        console.log(`   Parsed id: ${processId}`)
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
