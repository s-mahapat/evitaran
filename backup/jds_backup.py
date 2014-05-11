#!/usr/bin/python
from datetime import date
import glob
import logging
import os
import subprocess


class Backup(object):

    def __init__(self):
        self.backup_path = r'/home/jds/evitaran_backups'

    def start_backup(self, backup_file=None):
        logging.info("backup started")
        if not backup_file:
            backup_file = self._get_backup_file_name()
        command = 'mysqldump --tables --triggers --routines --user root --password=jdsdbr00t --comments evitaran > ' + \
            backup_file
        p = subprocess.Popen(command, shell=True)
        p.wait()
        logging.info("backup completed to %s" % backup_file)

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
            logging.info("Not enough files to delete")
            return
        file_ctimes = []
        file_dict = {}
        # store the file creation times and file names in a dict
        # sort the file ctime and delete all files that are older than count
        # days
        for file_name in file_list:
            ctime = os.stat(file_name).st_ctime
            file_dict[ctime] = file_name
            file_ctimes.append(ctime)

        # sort the files on timestamp
        file_ctimes.sort()

        # delete old files
        for i in range(len(file_ctimes) - count):
            file_to_delete = file_dict[file_ctimes[i]]
            logging.info("Deleting file %s" % file_to_delete)
            os.unlink(file_to_delete)


if __name__ == '__main__':
    logging.basicConfig(filename='jds_backup.log',
                        format='%(asctime)s %(levelname)s:%(message)s',
                        level=logging.DEBUG)
    backup = Backup()
    backup.start_backup()
    backup.delete_old_backups()
