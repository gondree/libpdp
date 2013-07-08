#! /bin/bash

### First trial run of libpdpd, local using DevStack
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_gets.png  --Xattrib='File size (kb)' --Yattrib='GET')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_puts.png  --Xattrib='File size (kb)' --Yattrib='PUT' --Yscale='linear')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_tag_time.png  --Xattrib='File size (kb)' --Yattrib='Create tag')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_chal_time.png  --Xattrib='File size (kb)' --Yattrib='Create challenge')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_proof_time.png  --Xattrib='File size (kb)' --Yattrib='Create proof')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371021219.19_output.test_all_file_sizes.csv --output=output/filesize_vs_verify_time.png  --Xattrib='File size (kb)' --Yattrib='Verify file')

(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_gets.png  --Xattrib='Block size' --Yattrib='GET' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_puts.png  --Xattrib='Block size' --Yattrib='PUT' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_tag_time.png  --Xattrib='Block size' --Yattrib='Create tag' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_chal_time.png  --Xattrib='Block size' --Yattrib='Create challenge' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_proof_time.png  --Xattrib='Block size' --Yattrib='Create proof' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2013-06-12/1371014620.85_output.test_all_block_sizes.csv --output=output/blocksize_vs_verify_time.png  --Xattrib='Block size' --Yattrib='Verify file' --Xlabel='Block size (bytes)')

### Previous code, before libpdp was implemented
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_gets_ec2.png  --Xattrib='File size (kb)' --Yattrib='GET')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_puts_ec2.png  --Xattrib='File size (kb)' --Yattrib='PUT' --Yscale='linear')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_tag_time_ec2.png  --Xattrib='File size (kb)' --Yattrib='Create tag')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_chal_time_ec2.png  --Xattrib='File size (kb)' --Yattrib='Create challenge')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_proof_time_ec2.png  --Xattrib='File size (kb)' --Yattrib='Create proof')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-file-size-ec2 --output=output/filesize_vs_verify_time_ec2.png  --Xattrib='File size (kb)' --Yattrib='Verify file')

(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_gets_ec2.png  --Xattrib='Block size' --Yattrib='GET' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_puts_ec2.png  --Xattrib='Block size' --Yattrib='PUT' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_tag_time_ec2.png  --Xattrib='Block size' --Yattrib='Create tag' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_chal_time_ec2.png  --Xattrib='Block size' --Yattrib='Create challenge' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_proof_time_ec2.png  --Xattrib='Block size' --Yattrib='Create proof' --Xlabel='Block size (bytes)')
(python analysis.py --process-csv --csv-data=data-2012-09-14/all-times-block-size-ec2 --output=output/blocksize_vs_verify_time_ec2.png  --Xattrib='Block size' --Yattrib='Verify file' --Xlabel='Block size (bytes)')
