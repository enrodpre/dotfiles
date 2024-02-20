#!/bin/python
from functions import get_filename


def test_wo_ext():
    path = '/dev/null'
    actual = get_filename(path)
    expected = 'null'

    assert expected == actual


def test_with_ext():
    path = '/home/kike/.config/nvim/init.lua'
    actual = get_filename(path)
    expected = 'init'

    assert expected == actual
