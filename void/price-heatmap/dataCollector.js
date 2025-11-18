/**
 * Data collection script for California area code income data
 * @type {Object}
 */
const dataCollector = {
  /**
   * Main execution function
   * @returns {Promise<void>}
   */
  async collect() {
    try {
      // Replace with actual data source URL
      const dataSource = 'https://example.com/california-income-data.json';
      
      // Fetch raw data from source
      const response = await fetch(dataSource);
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      
      // Parse JSON data
      const rawData = await response.json();
      demon.log('Successfully fetched raw data');
      
      // Filter data for California (CA)
      const californiaData = rawData
        .filter(entry => entry.state === 'CA')
        .map(entry => ({
          areaCode: entry.areaCode,
          income: parseFloat(entry.medianIncome),
          population: parseInt(entry.population),
          county: entry.county
        }));
      
      // Sort data by income descending
      californiaData.sort((a, b) => b.income - a.income);
      
      // Save processed data to file
      await this.saveData(californiaData);
      demon.log('Data collection completed successfully');
    } catch (error) {
      demon.log(`Data collection failed: ${error.message}`);
      throw error;
    }
  },
  
  /**
   * Save processed data to file
   * @param {Object[]} data - Processed data to save
   * @returns {Promise<void>}
   */
  async saveData(data) {
    const fs = require('fs').promises;
    const filePath = './california-income-data.json';
    
    try {
      await fs.writeFile(filePath, JSON.stringify(data, null, 2));
      demon.log(`Data saved to ${filePath}`);
    } catch (error) {
      demon.log(`Failed to save data: ${error.message}`);
      throw error;
    }
  }
};

// Execute data collection
dataCollector.collect().catch(error => demon.log(`Critical error: ${error.message}`));
