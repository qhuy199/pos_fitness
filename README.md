# pos_fitness
Phiên bản có thông báo hoạt động, báo lỗi, track hành động.

Locate: 
c:\app\pos\fitness.bat

Required:
- File: c:\app\pos\pos.log
- c:\app\pos\7zip

Concept: 
- Lưu trư file log và tự động rorate trong 3 file zip

Operation:
- Nếu pos.log > 1G thì:
  - Nén bằng 7zip file pos.log thành tmp_poslog.zip
  - Xoá pos3.zip (nếu có), rename pos2.zip -> pos3.zip, rename pos1.zip -> pos2.zip
  - Rename tmp_poslog.zip thành pos1.zip
