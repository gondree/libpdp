#! /bin/bash
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'GET' --Xlabel 'Block size (bytes)') &
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'PUT' --Xlabel 'Block size (bytes)') &
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'Create tag' --Xlabel 'Block size (bytes)') &
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'Create challenge' --Xlabel 'Block size (bytes)') &
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'Create proof' --Xlabel 'Block size (bytes)') &
(./analysis.py --exp_path ../data/all-times-block-size-ec2/ --Xattrib 'Block size' --Yattrib 'Verify file' --Xlabel 'Block size (bytes)') &
