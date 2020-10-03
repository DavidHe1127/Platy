'use strict';

exports.handler = (event, context, callback) => {
  let success = 0; // Number of valid entries found
  let failure = 0; // Number of invalid entries found

  /* Process the list of records and transform them */
  const output = event.records.map((record) => {
    // Kinesis data is base64 encoded so decode here
    console.log(record.recordId);
    const payload = Buffer.from(record.data, 'base64').toString('ascii');
    console.log('Decoded payload:', payload);

    // Split the data into it's fields so we can refer to them by index
    const match = payload.split('|');

    if (match) {
      /* Prepare JSON version from Syslog log data */
      const result = {
        // build all fields from array
        crime_time: match[0],
        address: match[1],
        district: parseInt(match[2]),
        beat: match[3],
        grid: parseInt(match[4]),
        description: match[5],
        crime_id: parseInt(match[6]),
        latitude: parseFloat(match[7]),
        longitude: parseFloat(match[8]),
        load_time: match[9],
        location: {
          lat: parseFloat(match[7]),
          lon: parseFloat(match[8]),
        },
      };
      success++;
      return {
        recordId: record.recordId,
        result: 'Ok',
        data: Buffer.from(JSON.stringify(result)).toString('base64'),
      };
    } else {
      /* Failed event, notify the error and leave the record intact */
      failure++;
      return {
        recordId: record.recordId,
        result: 'ProcessingFailed',
        data: record.data,
      };
    }
  });
  console.log(
    `Processing completed.  Successful records ${success}, Failed records ${failure}.`
  );
  callback(null, { records: output });
};
