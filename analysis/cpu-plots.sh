#! /bin/bash
(./analysis.py --exp_path ../data/all-times-cpu/ --Xattrib 'File size (kb)' --Yattrib 'Create tag' --Ylabel 'Create tag (sec)') &
(./analysis.py --exp_path ../data/all-times-cpu/ --Xattrib 'File size (kb)' --Yattrib 'Create challenge' --Ylabel 'Create challenge (sec)') &
(./analysis.py --exp_path ../data/all-times-cpu/ --Xattrib 'File size (kb)' --Yattrib 'Create proof' --Ylabel 'Create proof (sec)') &
(./analysis.py --exp_path ../data/all-times-cpu/ --Xattrib 'File size (kb)' --Yattrib 'Verify file' --Ylabel 'Verify file (sec)') &
