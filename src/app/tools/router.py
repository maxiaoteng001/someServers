import string
import random
import logging
from fastapi import APIRouter, Request


router = APIRouter()


@router.get("/gen_passwd")
async def gen_passwd(request: Request, passwd_length: int=16):
    new_passwd = ''.join([random.choice(string.ascii_letters + string.digits) for _ in range(passwd_length)])
    logging.info('生成随机密码:{}'.format(new_passwd))

    return {'new_passwd': new_passwd}
