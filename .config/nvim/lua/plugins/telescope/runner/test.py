#!/usr/bin/python3

import pynvim
import os.path
import gc
import time
import signal
import sys
from contextlib import ContextDecorator
from functools import wraps


def on_sigint(sig, frame):
    print("[x] Received SIGINT")
    print("Exiting...")
    sys.exit(1)


signal.signal(signal.SIGINT, on_sigint)

argv = [
    "/usr/bin/env",
    "nvim",
    "--embed",
    "--headless",
    # "-n",
]

FILENAME = "data.lua"


class NvimRunner:
    PIPENAME = "/tmp/nvim"
    NUMBER_OF_TRIES = 10

    __nvim: pynvim.Nvim

    @property
    def nvim(self):
        return self.__nvim

    @nvim.setter
    def nvim(self, nvim):
        self.__nvim = nvim

    def __attach(self):
        for _ in range(self.NUMBER_OF_TRIES):
            # if os.path.lexists(self.PIPENAME):
            self.nvim = pynvim.attach("child", argv=argv)
            if self.nvim:
                break
            time.sleep(0.5)

        if not self.nvim:
            raise Exception("Connection error")

    def __enter__(self):
        self.__attach()
        return self.nvim

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("exiting...")
        self.nvim.quit()
        self.nvim.close()

        gc.collect()


@NvimRunner("nvim")
def loop(nvim):
    nvim.command(f"e {FILENAME}")
    nvim.current.window.cursor = (25, 24)

    # nvim.exec_lua("nvim_ui_attach(50,50)")
    print(nvim.exec_lua("vim.api.nvim_get_mode()"))
    nvim.exec_lua('require("plugins.telescope.builtin").inspect()')
    print(nvim.exec_lua("vim.api.nvim_get_mode()"))

    print(nvim.command_output("call getcmdline()"))
    # vim.api.strwith("asd")
    enter = nvim.replace_termcodes("<CR>")
    nvim.feedkeys(enter)


def main():
    while True:
        loop()


if __name__ == "__main__":
    main()
