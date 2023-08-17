import markdown
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--input", required=True)
parser.add_argument("--output", required=True)
args = parser.parse_args()

inputFilename = args.input
outputFilename = args.output

print("Input filename:" + inputFilename)
print("Output filename:" + outputFilename)

with open(inputFilename, 'r') as inputFile:
    inputData = inputFile.read()

with open(outputFilename, 'w') as outputFile:
    outputFile.write('<html>\n' + markdown.markdown(inputData).replace('’', "'").replace("‘", "'").replace('”', '"').replace('“', '"') + '\n</html>')