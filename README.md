# pos_gym
Phiên bản rút gọn, bỏ qua các báo lỗi hệ thống, cứ 50M thì bắt đầu nén, chia làm 5 file zip

Locate: 
c:\app\pos\gym.bat

Required:
FILE c:\app\pos\pos.log
FOLDER c:\app\pos\7zip

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

# pos_fitness
Phiên bản có thông báo hoạt động, báo lỗi, track hành động.

Locate: 
c:\app\pos\fitness.bat

Required:
c:\app\pos\pos.log
c:\app\pos\7zip

Concept: 
- Lưu trư file log và tự động rorate trong 3 file zip

Operation:
- Nếu pos.log > 1G thì:
  - Nén bằng 7zip file pos.log thành tmp_poslog.zip
  - Xoá pos3.zip (nếu có), rename pos2.zip -> pos3.zip, rename pos1.zip -> pos2.zip
  - Rename tmp_poslog.zip thành pos1.zip
