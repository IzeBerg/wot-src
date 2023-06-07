import csv, logging, BigWorld

class ReportGenerator(object):

    def __init__(self):
        self.__location = None
        self.__isCollectingData = False
        self.__collectedData = None
        return

    @property
    def location(self):
        return self.__location

    def setLocation(self, location):
        self.__location = location

    @property
    def isCollectingData(self):
        return self.__isCollectingData

    @property
    def collectedData(self):
        return self.__collectedData

    def startCollectingData(self):
        if self.location is None:
            logging.error('cannot start collecting data - the location for reports was not provided...')
            return
        else:
            if self.__isCollectingData:
                logging.error('cannot start collecting data - the benchmarking tool is already collecting it...')
                return
            self.__isCollectingData = True
            BigWorld.startBenchmarkTool()
            self.__collectedData = None
            return

    def stopCollectingData(self):
        if self.location is None:
            logging.error('cannot stop collecting data - the location for reports was not provided...')
            return
        else:
            if not self.__isCollectingData:
                logging.error('cannot stop collecting data - the benchmarking tool is not already collecting it...')
                return
            self.__collectedData = None if not self.__isCollectingData else BigWorld.stopBenchmarkTool()
            self.__isCollectingData = False
            return

    def generateReport(self):
        if self.__location is None:
            logging.error('failed to generate a report - location was not provided (None)!')
            return
        else:
            if self.__isCollectingData is None:
                logging.error('failed to generate a report - the data is still being collected! Use stopCollectingData() to complete data collection and enable report generation')
                return
            if self.__collectedData is None:
                logging.error('failed to generate a report - benchmarking data was invalid (None)!')
                return
            with open(self.__location, 'wb') as (f):
                writer = csv.writer(f)
                writer.writerow(self.__collectedData.keys())
                writer.writerow(self.__collectedData.values())
            return