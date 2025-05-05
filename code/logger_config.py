import logging
from logging.handlers import RotatingFileHandler

# Create a logger
logger = logging.getLogger("archive_logger")
logger.setLevel(logging.INFO)  # Set the logging level

# Create a rotating file handler
log_file = 'archive.log'
max_log_size = 5 * 1024 * 1024  # Max log file size (5 MB)
backup_count = 3  # Keep up to 3 backup files

rotating_handler = RotatingFileHandler(log_file, maxBytes=max_log_size, backupCount=backup_count)
rotating_handler.setLevel(logging.DEBUG)

# Create a stream handler (for console output)
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# Create a formatter
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# Add formatter to handlers
rotating_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# Add handlers to the logger
logger.addHandler(rotating_handler)
logger.addHandler(console_handler)  # Add console handler
