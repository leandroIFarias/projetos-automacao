import re

from robot.api.deco import keyword
from dataclasses import replace

@keyword('Regex Capturar Numero')
def RegexCapturarNumero(str):
    p = '[\d]+[.,\d]+|[\d]*[.][\d]+|[\d]+'
    if re.search(p, str) is not None:
        for  catch in re.finditer(p, str):
         print(catch[0]) # catch is a match object

    return catch[0]