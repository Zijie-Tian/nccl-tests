import argparse
import pandas as pd
from pprint import pprint
import io

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file', help='nccl-test output file path', required=True)
    parser.add_argument('-o', '--out-file', help='output file name', required=True)
    return parser.parse_args()

def clean_headers(f):
    def checkstart(line, start='#'):
        return line.startswith(start)
    
    line = f.readline()
    if checkstart(line, '-'):
        while True:
            line = f.readline()
            if checkstart(line, '#'):
                break

    ret = []
    while True:
        line = f.readline()
        if not line:
            break
        if checkstart(line, start='#'):
            continue
        else:
            ret.append(line)
    
    return ret

if __name__ == '__main__':
    args = parse_args()

    with open(args.file, 'r') as f:
        lines = clean_headers(f)

    col_names = ['size(Bytes)', 'Count', 'type', 'redop', 'root', 
                 'op time(us)', 'op algbw(GB/s)', 'op busbw(GB/s)', 'op # of wrong', 
                 'ip time(us)', 'ip algbw(GB/s)', 'ip busbw(GB/s)', 'ip # of wrong']
    
    df = pd.read_csv(io.StringIO('\n'.join(lines)), names=col_names, delim_whitespace=True)
    # print(df)
    df.to_csv(args.out_file, index=False)
