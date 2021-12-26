#!/usr/bin/env python3

import os
import yaml
import boto3
import confuse


from python_terraform import *


def main():
    global config
    config = confuse.Configuration('terraform-aws', __name__)
    config.set_file('config.yaml')

    initAll()

def initAll():
    keySSH = config['key_name'].get()
    bucketS3 = config['bucketS3'].get()

    print('#' * 50)
    getPrices()

    s3 = boto3.resource('s3')
    s3.Bucket(bucketS3).download_file(keySSH, f'.secrets/{keySSH}')

    t = Terraform()
    print('-' * 50)
    return_code, stdout, stderr = t.init(reconfigure=True)
    if return_code == 1:
        print(stderr)
    else:
        print("Terraform has been successfully initialized!")
    print('-' * 50)
    print('#' * 50)


def getPrices():
    instanceType = config['instanceType'].get()
    AvailabilityZone = config['AvailabilityZone'].get()
    client=boto3.client('ec2',region_name=config['region'].get())

    prices=client.describe_spot_price_history(InstanceTypes=[instanceType],
                                            MaxResults=1,
                                            ProductDescriptions=['Linux/UNIX'],
                                            AvailabilityZone=AvailabilityZone)
    SpotPrice = prices['SpotPriceHistory'][0]['SpotPrice']

    return SpotPrice

if __name__ == '__main__':
    main()
