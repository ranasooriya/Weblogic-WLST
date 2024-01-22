#####################################################################################
#
# This Script contain methods to addTarget and unTarget of Data Source in domain
# This is supposed to use for Targeting/UnTargeting DS process which ASG perform while DR FailOver
# Author : Ishanka Ranasooriya
# Date : 2016 June 06
# Version : 1.0
#
#####################################################################################
 
from java.io import FileInputStream
 
propInputStream = FileInputStream("DsDetails.properties")
configProps = Properties()
configProps.load(propInputStream)
 
userName = configProps.get("userName")
password = configProps.get("password")
adminUrl = configProps.get("admin.Url")
totalDsCount = configProps.get("total.Ds.Count")
 
connect(userName,password,adminUrl)
edit()
startEdit()
print ''
print '==============================================='
print 'UnTargeting of the DataSources has started.....'
print '==============================================='
 
dsCount=1
while (dsCount <= int(totalDsCount)) :
    dsName = configProps.get("ds.Name."+ str(dsCount))
    tgName = configProps.get("target")
    cd ('/JDBCSystemResources/'+ dsName)
    set('Targets',jarray.array([], ObjectName))
    print ''
    print 'DataSource = ', dsName ,', has been UnTargeted'
    print ''
    dsCount = dsCount + 1
 
print '====================================================='
print 'UnTrageting of the DataSources has been completed !!!'
print '====================================================='
print ''
 
activate()
exit()