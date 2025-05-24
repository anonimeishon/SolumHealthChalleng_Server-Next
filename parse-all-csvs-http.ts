import * as fs from 'fs';
import * as path from 'path';
import XLSX from 'xlsx';

// Simple CSV parser function (currently unused if only processing XLSX)
// function parseCSV(content: string): any[] { ... }

async function processCSVFile(filename: string, description: string) {
  console.log(`\n📁 Processing ${description} (File: ${filename})`);

  const filePath = path.join(__dirname, filename);

  if (!fs.existsSync(filePath)) {
    console.log(`   ❌ File not found: ${filename}`);
    return { processed: 0, errors: 1 };
  }

  try {
    const workbook = XLSX.readFile(filePath);

    // Helper to parse sheet to JSON and stringify all values
    const getProcessedSheetData = (
      sheetNameFromWorkbook: string | undefined,
    ): any[] => {
      if (!sheetNameFromWorkbook || !workbook.Sheets[sheetNameFromWorkbook]) {
        console.warn(
          `   ⚠️ Sheet (name/index provided: ${sheetNameFromWorkbook}) not found or invalid in ${filename}.`,
        );
        return [];
      }
      // Use defval: '' to ensure empty cells become empty strings, simplifying conversion
      const sheetObjects: any[] = XLSX.utils.sheet_to_json(
        workbook.Sheets[sheetNameFromWorkbook],
        { raw: true, defval: '' },
      );
      return sheetObjects.map((rowObject) => {
        const stringifiedRow: { [key: string]: string } = {};
        for (const key in rowObject) {
          if (Object.prototype.hasOwnProperty.call(rowObject, key)) {
            stringifiedRow[key] = String(rowObject[key]); // Convert all cell values to string
          }
        }
        return stringifiedRow;
      });
    };

    // Process sheets by index (0 for C, 1 for B, 2 for A)
    // const clinicC_Data = getProcessedSheetData(workbook.SheetNames[0]); // Skip Clinic C
    const clinicB_Data = getProcessedSheetData(workbook.SheetNames[1]);
    const clinicA_Data = getProcessedSheetData(workbook.SheetNames[2]);

    const clientsToProcess = [
      // { data: clinicC_Data, nameSuffix: "Clinic C Data", originalSheetName: workbook.SheetNames[0] }, // Skipping Clinic C
      {
        data: clinicB_Data,
        nameSuffix: 'Clinic B Data',
        originalSheetName: workbook.SheetNames[1],
      },
      {
        data: clinicA_Data,
        nameSuffix: 'Clinic A Data',
        originalSheetName: workbook.SheetNames[2],
      },
    ];

    let totalProcessedForFile = 0;
    let totalErrorsForFile = 0;

    for (const client of clientsToProcess) {
      if (!client.data || client.data.length === 0) {
        console.log(
          `   ℹ️ No data for ${client.nameSuffix} (Sheet: ${client.originalSheetName || 'N/A'}) or sheet not found.`,
        );
        continue;
      }

      console.log(
        `\n   📄 Processing ${client.nameSuffix} (Sheet: ${client.originalSheetName})`,
      );
      console.log(`   📊 Found ${client.data.length} records`);

      if (client.data.length > 0 && client.data[0]) {
        const headers = Object.keys(client.data[0]);
        console.log(
          `   📋 Headers (${headers.length}): ${headers.slice(0, 5).join(', ')}${headers.length > 5 ? '...' : ''}`,
        );
      }

      const companyForSheet = `${description} - ${client.nameSuffix}`;
      console.log(
        `   ⚙️  Sending data for ${companyForSheet} to ingestion service...`,
      );

      const payload = {
        companyName: companyForSheet,
        rows: client.data,
      };

      try {
        const response = await fetch(
          'http://localhost:8080/data-ingestion/ingest', // Changed port to 8080
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload),
          },
        );

        if (response.ok) {
          const result = (await response.json()) as { message: string };
          console.log(
            `   ✅ Success for ${client.nameSuffix}:`,
            result.message,
          );
          totalProcessedForFile += client.data.length;
        } else {
          const errorText = await response.text();
          console.log(
            `   ❌ Error for ${client.nameSuffix} (Status: ${response.status}):`,
            errorText.substring(0, 500),
          );
          totalErrorsForFile += client.data.length;
        }
      } catch (fetchError: any) {
        console.log(
          `   ❌ Fetch error for ${client.nameSuffix}:`,
          fetchError.message,
        );
        totalErrorsForFile += client.data.length;
      }
    } // End of loop for client sheets

    return { processed: totalProcessedForFile, errors: totalErrorsForFile };
  } catch (e: any) {
    console.log(`   ❌ Processing error for ${filename}:`, e.message);
    return { processed: 0, errors: 1 };
  }
}

async function parseAllCSVs() {
  console.log('🚀 Starting CSV Parsing for All Clinic Files\n');
  console.log('===========================================');

  const csvFiles = [
    // {
    //   filename: 'SolumClinicA.csv',
    //   description: 'Clinic A - Comprehensive LLM Data',
    // },
    // { filename: 'solumClinicB.csv', description: 'Clinic B - QA Evaluations' },
    // {
    //   filename: 'SolumClinicC.csv',
    //   description: 'Clinic C - Basic Evaluations',
    // },
    {
      filename: 'techXLSX.xlsx',
      description: 'Clinic',
    },
  ];

  let totalProcessed = 0;
  let totalErrors = 0;

  for (const csvFile of csvFiles) {
    const result = await processCSVFile(csvFile.filename, csvFile.description);
    if (result) {
      totalProcessed += result.processed;
      totalErrors = result.errors;
    }
  }

  // Get final database status
  console.log(`\n📊 FINAL SUMMARY`);
  console.log(`===============`);
  console.log(`Total records processed: ${totalProcessed}`);
  console.log(`Total errors: ${totalErrors}`);

  try {
    const statusResponse = await fetch(
      'http://localhost:3000/data-ingestion/status',
    );
    if (statusResponse.ok) {
      const status = await statusResponse.json();
      console.log(`\n📈 Final Database Status:`);
      if (status.tables) {
        console.log(`   Companies: ${status.tables.companies}`);
        console.log(`   Agents: ${status.tables.agents}`);
        console.log(`   Calls: ${status.tables.calls}`);
        console.log(`   Human Evaluations: ${status.tables.humanEvaluations}`);
        console.log(`   LLM Evaluations: ${status.tables.llmEvaluations}`);
      }
      console.log(`   Status: ${status.status}`);
    }
  } catch (error) {
    console.log('❌ Error getting final status:', (error as Error).message);
  }

  console.log('\n🎉 All CSV files processed successfully!');
}

// Add fetch polyfill for Node.js
if (typeof fetch === 'undefined') {
  // @ts-ignore
  global.fetch = require('node-fetch');
}

parseAllCSVs().catch((error) => {
  console.error('❌ Script failed:', error);
  process.exit(1);
});
