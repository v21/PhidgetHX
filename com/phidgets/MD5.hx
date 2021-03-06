//An ActionScript implementation of the RSA Data Security, Inc. MD5 Message
// Digest Algorithm, as defined in RFC 1321.
// Version 2.1 Copyright (C) Paul Johnston 1999 - 2002.
// Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
// Distributed under the BSD License // See http://pajhome.org.uk/crypt/md5 for more info.
//
// Optimized and componentized by Branden J. Hall
// Further optimized by IT GlobalSecure, Inc.





//--------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------
// MD5 component
// v 1.1
// 3/20/2003
//--------------------------------------------------------------------------------------------
// An implementation of the RSA Data Security, Inc. MD5 Message
// Digest Algorithm, as defined in RFC 1321.
// Version 2.1 Copyright (C) Paul Johnston 1999 - 2002.
// Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
// Distributed under the BSD License
// See http://pajhome.org.uk/crypt/md5 for more info.
//
// Optimized and componentized by Branden J. Hall
// Further optimized by IT GlobalSecure.
// To download the latest version
// or extend security tools for ActionScript, please visit: www.secureplay.com
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


//
// Configurable variables. You may need to tweak these to be compatible with
// the server-side, but the defaults work in most cases.
//

package com.phidgets;



class MD5
{  //_global.MD5 = new Object();  
    
    public static var hexcase : Int = 0;  /* hex output format. 0 - lowercase; 1 - uppercase        */  
    public static var b64pad : String = "";  /* base-64 pad character. "=" for strict RFC compliance   */  
    public static var chrsz : Int = 8;  /* bits per input character. 8 - ASCII; 16 - Unicode      */  
    
    /*
 * These are the functions you'll usually want to call
 * They take string arguments and return either hex or base-64 encoded strings
 */
    public static function hex_md5(s : String) : String{
        return binl2hex(core_md5(str2binl(s), s.length * chrsz));
    }
    
    public static function b64_md5(s : String) : String{
        return binl2b64(core_md5(str2binl(s), s.length * chrsz));
    }
    
    public static function str_md5(s : String) : String{
        return binl2str(core_md5(str2binl(s), s.length * chrsz));
    }
    
    public static function hex_hmac_md5(key : String, data : String) : String{
        return binl2hex(core_hmac_md5(key, data));
    }
    
    public static function b64_hmac_md5(key : String, data : String) : String{
        return binl2b64(core_hmac_md5(key, data));
    }
    
    public static function str_hmac_md5(key : String, data : String) : String{
        return binl2str(core_hmac_md5(key, data));
    }
    
    //
    // Perform a simple self-test to see if the VM is working
    //
    public static function md5_vm_test() : Bool{
        return hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
    }
    
    //
    // Calculate the MD5 of an array of little-endian words, and a bit length
    //
    public static function core_md5(x : Array<Dynamic>, len : Int) : Array<Dynamic>{
        var olda : Int;
        var oldb : Int;
        var oldc : Int;
        var oldd : Int;
        
        /* append padding */
        // x[len >> 5] |= 0x80 << ((len) % 32); // original code
        x[len >> 5] |= 0x80 << ((len) & 31);  // proposed alternative  
        
        x[(((len + 64) >>> 9) << 4) + 14] = len;
        
        var a : Int = 1732584193;
        var b : Int = -271733879;
        var c : Int = -1732584194;
        var d : Int = 271733878;
        
        var max : Int = x.length;
        var i : Int = 0;
        while (i < max){
            olda = a;
            oldb = b;
            oldc = c;
            oldd = d;
            
            a = md5_ff(a, b, c, d, x[i + 0], 7, -680876936);
            d = md5_ff(d, a, b, c, x[i + 1], 12, -389564586);
            c = md5_ff(c, d, a, b, x[i + 2], 17, 606105819);
            b = md5_ff(b, c, d, a, x[i + 3], 22, -1044525330);
            a = md5_ff(a, b, c, d, x[i + 4], 7, -176418897);
            d = md5_ff(d, a, b, c, x[i + 5], 12, 1200080426);
            c = md5_ff(c, d, a, b, x[i + 6], 17, -1473231341);
            b = md5_ff(b, c, d, a, x[i + 7], 22, -45705983);
            a = md5_ff(a, b, c, d, x[i + 8], 7, 1770035416);
            d = md5_ff(d, a, b, c, x[i + 9], 12, -1958414417);
            c = md5_ff(c, d, a, b, x[i + 10], 17, -42063);
            b = md5_ff(b, c, d, a, x[i + 11], 22, -1990404162);
            a = md5_ff(a, b, c, d, x[i + 12], 7, 1804603682);
            d = md5_ff(d, a, b, c, x[i + 13], 12, -40341101);
            c = md5_ff(c, d, a, b, x[i + 14], 17, -1502002290);
            b = md5_ff(b, c, d, a, x[i + 15], 22, 1236535329);
            
            a = md5_gg(a, b, c, d, x[i + 1], 5, -165796510);
            d = md5_gg(d, a, b, c, x[i + 6], 9, -1069501632);
            c = md5_gg(c, d, a, b, x[i + 11], 14, 643717713);
            b = md5_gg(b, c, d, a, x[i + 0], 20, -373897302);
            a = md5_gg(a, b, c, d, x[i + 5], 5, -701558691);
            d = md5_gg(d, a, b, c, x[i + 10], 9, 38016083);
            c = md5_gg(c, d, a, b, x[i + 15], 14, -660478335);
            b = md5_gg(b, c, d, a, x[i + 4], 20, -405537848);
            a = md5_gg(a, b, c, d, x[i + 9], 5, 568446438);
            d = md5_gg(d, a, b, c, x[i + 14], 9, -1019803690);
            c = md5_gg(c, d, a, b, x[i + 3], 14, -187363961);
            b = md5_gg(b, c, d, a, x[i + 8], 20, 1163531501);
            a = md5_gg(a, b, c, d, x[i + 13], 5, -1444681467);
            d = md5_gg(d, a, b, c, x[i + 2], 9, -51403784);
            c = md5_gg(c, d, a, b, x[i + 7], 14, 1735328473);
            b = md5_gg(b, c, d, a, x[i + 12], 20, -1926607734);
            
            a = md5_hh(a, b, c, d, x[i + 5], 4, -378558);
            d = md5_hh(d, a, b, c, x[i + 8], 11, -2022574463);
            c = md5_hh(c, d, a, b, x[i + 11], 16, 1839030562);
            b = md5_hh(b, c, d, a, x[i + 14], 23, -35309556);
            a = md5_hh(a, b, c, d, x[i + 1], 4, -1530992060);
            d = md5_hh(d, a, b, c, x[i + 4], 11, 1272893353);
            c = md5_hh(c, d, a, b, x[i + 7], 16, -155497632);
            b = md5_hh(b, c, d, a, x[i + 10], 23, -1094730640);
            a = md5_hh(a, b, c, d, x[i + 13], 4, 681279174);
            d = md5_hh(d, a, b, c, x[i + 0], 11, -358537222);
            c = md5_hh(c, d, a, b, x[i + 3], 16, -722521979);
            b = md5_hh(b, c, d, a, x[i + 6], 23, 76029189);
            a = md5_hh(a, b, c, d, x[i + 9], 4, -640364487);
            d = md5_hh(d, a, b, c, x[i + 12], 11, -421815835);
            c = md5_hh(c, d, a, b, x[i + 15], 16, 530742520);
            b = md5_hh(b, c, d, a, x[i + 2], 23, -995338651);
            
            a = md5_ii(a, b, c, d, x[i + 0], 6, -198630844);
            d = md5_ii(d, a, b, c, x[i + 7], 10, 1126891415);
            c = md5_ii(c, d, a, b, x[i + 14], 15, -1416354905);
            b = md5_ii(b, c, d, a, x[i + 5], 21, -57434055);
            a = md5_ii(a, b, c, d, x[i + 12], 6, 1700485571);
            d = md5_ii(d, a, b, c, x[i + 3], 10, -1894986606);
            c = md5_ii(c, d, a, b, x[i + 10], 15, -1051523);
            b = md5_ii(b, c, d, a, x[i + 1], 21, -2054922799);
            a = md5_ii(a, b, c, d, x[i + 8], 6, 1873313359);
            d = md5_ii(d, a, b, c, x[i + 15], 10, -30611744);
            c = md5_ii(c, d, a, b, x[i + 6], 15, -1560198380);
            b = md5_ii(b, c, d, a, x[i + 13], 21, 1309151649);
            a = md5_ii(a, b, c, d, x[i + 4], 6, -145523070);
            d = md5_ii(d, a, b, c, x[i + 11], 10, -1120210379);
            c = md5_ii(c, d, a, b, x[i + 2], 15, 718787259);
            b = md5_ii(b, c, d, a, x[i + 9], 21, -343485551);
            
            a = safe_add(a, olda);
            b = safe_add(b, oldb);
            c = safe_add(c, oldc);
            d = safe_add(d, oldd);
            i += 16;
        }
        var result : Array<Dynamic> = [a, b, c, d];
        return result;
    }
    
    //
    // These functions implement the four basic operations the algorithm uses.
    //
    
    
    public static function md5_cmn(q : Int, a : Int, b : Int, x : Int, s : Int, t : Int) : Int{
        var result : Int = safe_add(bit_rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b);
        return result;
    }
    
    public static function md5_ff(a : Int, b : Int, c : Int, d : Int, x : Int, s : Int, t : Int) : Int{
        return md5_cmn((b & c) | ((~b) & d), a, b, x, s, t);
    }
    
    public static function md5_gg(a : Int, b : Int, c : Int, d : Int, x : Int, s : Int, t : Int) : Int{
        return md5_cmn((b & d) | (c & (~d)), a, b, x, s, t);
    }
    
    public static function md5_hh(a : Int, b : Int, c : Int, d : Int, x : Int, s : Int, t : Int) : Int{
        return md5_cmn(b ^ c ^ d, a, b, x, s, t);
    }
    
    public static function md5_ii(a : Int, b : Int, c : Int, d : Int, x : Int, s : Int, t : Int) : Int{
        return md5_cmn(c ^ (b | (~d)), a, b, x, s, t);
    }
    
    //
    // Calculate the HMAC-MD5, of a key and some data
    //
    public static function core_hmac_md5(key : String, data : String) : Array<Dynamic>{
        var bkey : Array<Dynamic> = str2binl(key);
        if (bkey.length > 16) {
            bkey = core_md5(bkey, key.length * chrsz);
        }
        
        var ipad = new Array<Dynamic>();
        var opad = new Array<Dynamic>();
        for (i in 0...16){
            ipad[i] = bkey[i] ^ 0x36363636;
            opad[i] = bkey[i] ^ 0x5C5C5C5C;
        }
        
        var hash : Array<Dynamic> = core_md5(ipad.concat(str2binl(data)), 512 + data.length * chrsz);
        return core_md5(opad.concat(hash), 512 + 128);
    }
    
    //
    // Add integers, wrapping at 2^32. This uses 16-bit operations internally
    // to work around bugs in some JS interpreters.
    //
    // !!! Should validate whether this is necessary for ActionScript
    
    public static function safe_add(x : Int, y : Int) : Int{
        var lsw : Int = (x & 0xFFFF) + (y & 0xFFFF);
        var msw : Int = (x >> 16) + (y >> 16) + (lsw >> 16);
        return (msw << 16) | (lsw & 0xFFFF);
    }
    
    //
    // Bitwise rotate a 32-bit number to the left.
    //
    public static function bit_rol(num : Int, cnt : Int) : Int{
        return (num << cnt) | (num >>> (32 - cnt));
    }
    
    //
    // Convert a string to an array of little-endian words
    // If chrsz is ASCII, characters >255 have their hi-byte silently ignored.
    //
    public static function str2binl(str : String) : Array<Dynamic>{
        var bin : Array<Dynamic> = new Array<Dynamic>();
        var mask : Int = (1 << chrsz) - 1;
        var max : Int = str.length * chrsz;
        var i : Int = 0;
        while (i < max){
            // bin[i>>5] |= (str.charCodeAt(i / this.chrsz) & mask) << (i%32); // original code
            bin[i >> 5] |= (str.charCodeAt(Std.int(i / chrsz)) & mask) << (i & 31);
            i += chrsz;
        }
        return bin;
    }
    
    /*
 * Convert an array of little-endian words to a string
 */
    public static function binl2str(bin : Array<Dynamic>) : String{
        var str : String = "";
        var mask : Int = (1 << chrsz) - 1;
        var max : Int = bin.length * 32;
        var i : Int = 0;
        while (i < max){
            // str += String.fromCharCode((bin[i>>5] >>> (i % 32)) & mask); // original code
            str += String.fromCharCode((bin[i >> 5] >>> (i & 31)) & mask);
            i += chrsz;
        }
        return str;
    }
    
    /*
 * Convert an array of little-endian words to a hex string.
 */
    public static function binl2hex(binarray : Array<Dynamic>) : String{
        var hex_tab : String = (hexcase != 0) ? "0123456789ABCDEF" : "0123456789abcdef";
        var str : String = "";
        var max : Int = binarray.length * 4;
        for (i in 0...max){
            /* str += hex_tab.charAt((binarray[i>>2] >> ((i%4)*8+4)) & 0xF) +
hex_tab.charAt((binarray[i>>2] >> ((i%4)*8  )) & 0xF);
*/  // original code  
            str += hex_tab.charAt((binarray[i >> 2] >> ((i & 3) * 8 + 4)) & 0xF) +
            hex_tab.charAt((binarray[i >> 2] >> ((i & 3) * 8)) & 0xF);
        }
        return str;
    }
    
    /*
 * Convert an array of little-endian words to a base-64 string
 */
    public static function binl2b64(binarray : Array<Dynamic>) : String{
        var tab : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var str : String = "";
        var max : Int = binarray.length * 4;
        var m4x : Int = 4 * max;
        var i : Int = 0;
		var triplet:Int = -1;
        while (i < max){
            triplet = (((binarray[i >> 2] >> 8 * (i & 3)) & 0xFF) << 16)
            | (((binarray[i + 1 >> 2] >> 8 * ((i + 1) & 3)) & 0xFF) << 8)
            | ((binarray[i + 2 >> 2] >> 8 * ((i + 2) & 3)) & 0xFF);
            i += 3;
        }
        for (j in 0...4){
            // if(i * 8 + j * 6 > binarray.length * 32){ // original code
            if (i * 8 + j * 6 > m4x) {
                str += b64pad;
            }
            else {
                str += tab.charAt((triplet >> 6 * (3 - j)) & 0x3F);
            }
        }
        return str;
    }

    public function new()
    {
    }
}
