(function () {
    Array.prototype.indexOf = function (item) {
        for (var i = 0; i < this.length; i++) {
            if (this[i] === item) return i;
        }
        return -1;
    };

    Array.prototype.contains = function (item) {
        return this.indexOf(item) != -1;
    }

    Array.prototype.remove = function (item) {
        var index = this.indexOf(item);
        index !== -1 && this.splice(index, 1);
        return this;
    };

    /** 从对象数组中取出每个对象的一个属性值组成新数组 */
    Array.prototype.attributed = function (attr) {
        var values = [];
        for (var i = 0; i < this.length; i++) {
            values.push(this[i][attr]);
        }
        return values;
    };

    var join = Array.prototype.join;
    /** 重写join方法，追加连接对象属性值的功能 */
    Array.prototype.join = function (sep, attr) {
        if (typeof attr !== "string") {
            return join.call(this, sep);
        }
        return join.call(this.attributed(attr), sep);
    };

})();
