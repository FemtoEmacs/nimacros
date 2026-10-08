"""Compile tutorial oracles in a temporary directory; leave the source tree unchanged."""
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    with tempfile.TemporaryDirectory(prefix="nimacros-test-") as directory:
        work = Path(directory)
        hello = work / "hi.nim"
        hello.write_text('import os, std/terminal\nstyledEcho "Hi, ", styleItalic, fgBlue, paramStr(1)\n')
        cases = [(hello, ["Edward"], "Edward"),
                 (ROOT / "nimacros/src/zeller.nim", ["2016", "8", "31"], "3"),
                 (ROOT / "nimacros/src/iterfib.nim", ["5"], "13"),
                 (ROOT / "nimacros/src/iterfib.nim", ["12"], "377"),
                 (ROOT / "nimacros/src/recfib.nim", ["12"], "377")]
        for index, (source, arguments, expected) in enumerate(cases):
            executable = work / f"example-{index}"
            subprocess.run(["nim", "c", "--hints:off", f"--nimcache:{work / 'cache'}",
                            f"--out:{executable}", str(source)], check=True, timeout=60,
                           capture_output=True, text=True)
            result = subprocess.run([str(executable), *arguments], check=True,
                                    timeout=10, capture_output=True, text=True)
            if source == hello:
                assert expected in result.stdout, result.stdout
            else:
                assert result.stdout.strip() == expected, result.stdout
            print(f"PASS {source.name} {' '.join(arguments)} -> {expected}")
    print("5/5 tutorial compiler oracles passed")


if __name__ == "__main__":
    main()
