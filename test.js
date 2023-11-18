const numberOfCpuCoresInExadataDbServer = 44;
const numberOfExadataDbServers = 4;
const cpuSpeedOfExadataDbServer = 3.6;
const numberOfCpuCoresInExadataStorageServer = 20;
const numberOfExadataStorageServers = 7;
const cpuSpeedOfExadataStorageServer = 2.2;
const utilizationFactor = 0.5; // Input by user
const numberOfVCpuInASlot = 0.5; // Where do we source this?
const avgVCpuSpeed = 2.6; // Where do we source this?

const result =
(
  numberOfCpuCoresInExadataDbServer
  * numberOfExadataDbServers
  * cpuSpeedOfExadataDbServer
  + numberOfCpuCoresInExadataStorageServer
  * numberOfExadataStorageServers
  * cpuSpeedOfExadataStorageServer
)
  * utilizationFactor
  / 
  (numberOfVCpuInASlot * avgVCpuSpeed)

console.log('Expected:', result)
console.log('Actual: 362')
