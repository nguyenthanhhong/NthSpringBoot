function nvl(s1, s2) {
    if (s1 == null) {
        if (s2 == null) {
            return "";
        } else {
            return s2;
        }
    }
    return s1;
};
function fn_isIncludeSpecChar(str) {
    const regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    return regExp.test(str);
}

function fn_removeSpecChar(str) {
    var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    return str.replace(regExp, "");
};

String.prototype.lpad = function( maxLength, fillChar ) {
    var srcStr = this.substr( 0, maxLength );
    var cnt = 0;

    for( var inx = srcStr.length; inx < maxLength; inx++ ) {
        srcStr = fillChar.charAt(cnt) + srcStr;
        cnt++;
        cnt = ( cnt == fillChar.length ) ? 0 : cnt;
    }
    return srcStr;

};

