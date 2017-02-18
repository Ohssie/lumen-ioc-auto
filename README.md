## Motivation
Using Inversion of Control in frameworks such as [Laravel](https://laravel.com) makes eveything about it feel so magical. However, some of the commands we're used to are not available in [Lumen](https://lumen.laravel.com/docs). This script reduces the need to go through the process of manually setting them up especially as there are other important things to worry about when building your API.

## How to run
* Copy & Paste the script to the root directory of your Lumen project
* Make the script executable by running `chmod +x ./lumen-ioc-auto.sh`
* Execute the script with `./lumen-ioc-auto.sh`
* Follow the prompt and type the name of the model you want to generate IOC Containers for. E.g `Customer`
* You can run this script at any point in the development of your API

## Side Note
* I was unable to add the lines that create the migration files. If anyone could try and make that happen, it'll be swell.

Cheers!
