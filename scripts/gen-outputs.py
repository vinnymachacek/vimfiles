#!/usr/bin/env python
import sys, json, pprint

inObj =  json.loads(sys.stdin.read())



for resource in inObj["Resources"]:
	if not resource in inObj["Outputs"]:
		inObj["Outputs"][resource] = {}
		inObj["Outputs"][resource]["Value"]={}
		inObj["Outputs"][resource]["Value"]["Ref"] = str(resource)



print(json.dumps(inObj, sort_keys=True, indent=4))
