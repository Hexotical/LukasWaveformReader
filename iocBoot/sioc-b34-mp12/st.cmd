#!../../bin/rhel7-x86_64/LukasWaveformReader

#- You may have to change LukasWaveformReader to something else
#- everywhere it appears in this file

< envPaths
epicsEnvSet("FPGA_IP", "10.0.0.104")
epicsEnvSet("YAML_DIR", "${IOC_DATA}/${IOC}/yaml")
epicsEnvSet("YAML", "${YAML_DIR}/000TopLevel.yaml")
epicsEnvSet("DEFAULTS_FILE", "${YAML_DIR}/config/defaults.yaml")
cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/LukasWaveformReader.dbd"
LukasWaveformReader_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadRecords("db/xxx.db","user=lujko")


# yamlDownloader
DownloadYamlFile("${FPGA_IP}", "${YAML_DIR}")

## yamlLoader
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")

cpswLoadConfigFile("${DEFAULTS_FILE}", "mmio")




cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=lujko"
