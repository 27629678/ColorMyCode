var colors = {};

colors.originColorMap = {
    "red":      {"r": 255,  "g": 0,     "b": 0},
    "green":    {"r": 0,    "g": 255,   "b": 0},
    "blue":     {"r": 0,    "g": 0,     "b": 255}
};

colors.colorForWord = function (word) {
    var w = word.toLowerCase();
    ddlog.debug('word: ' + w);
    // return word;

    if (!colors.originColorMap[w]) {
        return;
    }

    return colors.originColorMap[w];
};

colors.greeting = function () {
    ddlog.debug('import test module successfully.');
}
