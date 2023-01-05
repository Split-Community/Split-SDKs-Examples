"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getFnName = void 0;
/**
 * Returns the name of a given function.
 */
function getFnName(fn) {
    if (fn.name)
        return fn.name;
    return (fn.toString().match(/function (.+?)\(/) || ['', ''])[1];
}
exports.getFnName = getFnName;
