'use strict';

import style from './style/main.styl';
import markup from './index.html';
import Elm from './src/Main.elm';

const mountNode = document.getElementById('main');

const app = Elm.Main.embed(mountNode);
