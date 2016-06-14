#!/usr/bin/env python
import sys, json, pprint

inObj =  json.loads(open(sys.argv[1]).read())["Parameters"]

listobj = [] 
for parameter in inObj.iterkeys():
    data={}
    data["ParameterKey"]=parameter
    if 'Default' in inObj[parameter]:
        data["ParameterValue"]=inObj[parameter]["Default"]
    else:
        data["ParameterValue"]=""
    data["UsePreviousValue"]=False
    listobj.append(data)


print(json.dumps(listobj, sort_keys=True, indent=4))
