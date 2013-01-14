#! /bin/bash
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'GET' --Xlabel 'File size (kb)') &
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'PUT' --Xlabel 'File size (kb)') &
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'Create tag' --Xlabel 'File size (kb)') &
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'Create challenge' --Xlabel 'File size (kb)') &
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'Create proof' --Xlabel 'File size (kb)') &
(./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'Verify file' --Xlabel 'File size (kb)') &
