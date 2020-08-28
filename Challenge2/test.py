#!/usr/bin/python3

import sys
import argparse
import json
import subprocess



def run_curl_command(args):
    print('/'.join(args))
    cmd = ['curl'] + ['/'.join(args)] 
    print (cmd)
    try:
        result = subprocess.run(cmd, stdout=subprocess.PIPE)
        result.check_returncode()
    
        return json.loads(result.stdout)
    except subprocess.CalledProcessError:
        sys.exit(result.returncode)

def main(args):
   URL = args.metadataURL[0]
   endpoint = args.endpoint[0]
   
  # print(endpoint)
  # print(URL)
   print( run_curl_command([URL, endpoint]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Querey AWS Metadata')
  
    parser.add_argument(
                'metadataURL', metavar='<metadataURL>', type=str, nargs=1,
                help='metadataURL of AWS/Google/Azure')  
    parser.add_argument(
            'endpoint', metavar='<endpoint>', type=str, nargs=1,
            help='Endpoint to query')
     
    
    args = parser.parse_args()
    main(args)