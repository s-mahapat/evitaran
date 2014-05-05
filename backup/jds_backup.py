#!/usr/bin/python
from datetime import date
import datetime
import glob
import os
import subprocess
import time


class Backup(object):

    def __init__(self):
        self.backup_path = r'/home/jds/evitaran_backups'

    def start_backup(self, backup_file=None):
      if not backup_file:
       backup_file = self._get_backup_file_name()
       command = 'mysqldump --user root --password=jdsdbr00t --comments evitaran > ' + backup_file
       p = subprocess.Popen(command, shell=True)
       p.wait()

    def _get_backup_file_name(self):
      if not os.path.isdir(self.backup_path):
        os.makedirs(self.backup_path)
      today = date.today()
      filename = today.strftime("%Y%m%d")
      return os.path.join(self.backup_path, filename + '.sql')

    def delete_old_backups(self, file_type="*.sql", count=5):
      file_list = glob.glob(os.path.join(self.backup_path, file_type))
      # if the file count is less than backup count return
      if len(file_list) <= count:
        return
      file_ctimes = []
      file_dict = {}
      # store the file creation times and file names in a dict
      # sort the file ctime and delete all files that are older than count days
      for file in file_list:
        ctime = os.stat(file).st_ctime
        file_dict[ctime] = file
        file_ctimes.append(ctime)

      # sort the files on timestamp
      file_ctimes.sort()

      # delete old files
      for i in range(len(file_ctimes) - count):
        os.unlink(file_dict[i])




if __name__ == '__main__':
  backup = Backup()
  backup.delete_old_backups()
  backup.start_backup()
