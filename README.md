# pos_gym
Phiên bản rút gọn, bỏ qua các báo lỗi hệ thống, cứ 50M thì bắt đầu nén, chia làm 5 file zip

Locate: 
- c:\app\pos\start.bat

Required:
- FILE c:\app\pos\pos.log
- FOLDER c:\app\pos\7zip

Concept: 
- Lưu trư file log và tự động rorate trong 5 file zip

Operation:
- Nếu pos.log > 50MB thì:
  - Xoá pos5.zip (nếu có)
  - rename pos4.zip -> pos5.zip
  - rename pos3.zip -> pos4.zip
  - rename pos2.zip -> pos3.zip
  - rename pos1.zip -> pos2.zip
  - Nén bằng 7zip file pos.log thành pos1.zip
