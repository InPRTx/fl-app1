let wasm;

function getArrayU32FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint32ArrayMemory0().subarray(ptr / 4, ptr / 4 + len);
}

let cachedDataViewMemory0 = null;

function getDataViewMemory0() {
    if (cachedDataViewMemory0 === null || cachedDataViewMemory0.buffer.detached === true || (cachedDataViewMemory0.buffer.detached === undefined && cachedDataViewMemory0.buffer !== wasm.memory.buffer)) {
        cachedDataViewMemory0 = new DataView(wasm.memory.buffer);
    }
    return cachedDataViewMemory0;
}

function getStringFromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return decodeText(ptr, len);
}

let cachedUint32ArrayMemory0 = null;

function getUint32ArrayMemory0() {
    if (cachedUint32ArrayMemory0 === null || cachedUint32ArrayMemory0.byteLength === 0) {
        cachedUint32ArrayMemory0 = new Uint32Array(wasm.memory.buffer);
    }
    return cachedUint32ArrayMemory0;
}

let cachedUint8ArrayMemory0 = null;

function getUint8ArrayMemory0() {
    if (cachedUint8ArrayMemory0 === null || cachedUint8ArrayMemory0.byteLength === 0) {
        cachedUint8ArrayMemory0 = new Uint8Array(wasm.memory.buffer);
    }
    return cachedUint8ArrayMemory0;
}

function passStringToWasm0(arg, malloc, realloc) {
    if (realloc === undefined) {
        const buf = cachedTextEncoder.encode(arg);
        const ptr = malloc(buf.length, 1) >>> 0;
        getUint8ArrayMemory0().subarray(ptr, ptr + buf.length).set(buf);
        WASM_VECTOR_LEN = buf.length;
        return ptr;
    }

    let len = arg.length;
    let ptr = malloc(len, 1) >>> 0;

    const mem = getUint8ArrayMemory0();

    let offset = 0;

    for (; offset < len; offset++) {
        const code = arg.charCodeAt(offset);
        if (code > 0x7F) break;
        mem[ptr + offset] = code;
    }
    if (offset !== len) {
        if (offset !== 0) {
            arg = arg.slice(offset);
        }
        ptr = realloc(ptr, len, len = offset + arg.length * 3, 1) >>> 0;
        const view = getUint8ArrayMemory0().subarray(ptr + offset, ptr + len);
        const ret = cachedTextEncoder.encodeInto(arg, view);

        offset += ret.written;
        ptr = realloc(ptr, len, offset, 1) >>> 0;
    }

    WASM_VECTOR_LEN = offset;
    return ptr;
}

let cachedTextDecoder = new TextDecoder('utf-8', {ignoreBOM: true, fatal: true});
cachedTextDecoder.decode();
const MAX_SAFARI_DECODE_BYTES = 2146435072;
let numBytesDecoded = 0;

function decodeText(ptr, len) {
    numBytesDecoded += len;
    if (numBytesDecoded >= MAX_SAFARI_DECODE_BYTES) {
        cachedTextDecoder = new TextDecoder('utf-8', {ignoreBOM: true, fatal: true});
        cachedTextDecoder.decode();
        numBytesDecoded = len;
    }
    return cachedTextDecoder.decode(getUint8ArrayMemory0().subarray(ptr, ptr + len));
}

const cachedTextEncoder = new TextEncoder();

if (!('encodeInto' in cachedTextEncoder)) {
    cachedTextEncoder.encodeInto = function (arg, view) {
        const buf = cachedTextEncoder.encode(arg);
        view.set(buf);
        return {
            read: arg.length,
            written: buf.length
        };
    }
}

let WASM_VECTOR_LEN = 0;

const POWSolverFinalization = (typeof FinalizationRegistry === 'undefined')
    ? {
        register: () => {
        }, unregister: () => {
        }
    }
    : new FinalizationRegistry(ptr => wasm.__wbg_powsolver_free(ptr >>> 0, 1));

/**
 * POW验证码计算 - WASM优化版本
 *
 * 使用Rust编写，编译为WASM模块，提供高性能的SHA256计算
 *
 * # 性能优势
 * - 原生代码速度（接近本地C/Rust性能）
 * - 比纯JS实现快5-10倍
 * - 比Dart在Web上的实现快3-5倍
 */
export class POWSolver {
    /**
     * 创建新的POW求解器
     *
     * # 参数
     * - `cap_id`: 验证码UUID
     * - `difficulty`: 难度级别（前导零的数量）
     * @param {string} cap_id
     * @param {number} difficulty
     */
    constructor(cap_id, difficulty) {
        const ptr0 = passStringToWasm0(cap_id, wasm.__wbindgen_export2, wasm.__wbindgen_export3);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.powsolver_new(ptr0, len0, difficulty);
        this.__wbg_ptr = ret >>> 0;
        POWSolverFinalization.register(this, this.__wbg_ptr, this);
        return this;
    }

    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        POWSolverFinalization.unregister(this);
        return ptr;
    }

    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_powsolver_free(ptr, 0);
    }

    /**
     * 批量计算多个挑战的解决方案
     *
     * # 参数
     * - `start_index`: 起始索引
     * - `count`: 计算数量
     *
     * # 返回
     * 解决方案数组
     * @param {number} start_index
     * @param {number} count
     * @returns {Uint32Array}
     */
    solve_batch(start_index, count) {
        try {
            const retptr = wasm.__wbindgen_add_to_stack_pointer(-16);
            wasm.powsolver_solve_batch(retptr, this.__wbg_ptr, start_index, count);
            var r0 = getDataViewMemory0().getInt32(retptr + 4 * 0, true);
            var r1 = getDataViewMemory0().getInt32(retptr + 4 * 1, true);
            var v1 = getArrayU32FromWasm0(r0, r1).slice();
            wasm.__wbindgen_export(r0, r1 * 4, 4);
            return v1;
        } finally {
            wasm.__wbindgen_add_to_stack_pointer(16);
        }
    }

    /**
     * 计算单个挑战的解决方案
     *
     * # 参数
     * - `index`: 挑战索引
     *
     * # 返回
     * 找到的解决方案数值
     * @param {number} index
     * @returns {number}
     */
    solve_single(index) {
        const ret = wasm.powsolver_solve_single(this.__wbg_ptr, index);
        return ret >>> 0;
    }

    /**
     * 计算所有挑战的解决方案
     *
     * # 参数
     * - `challenge_count`: 总挑战数量
     *
     * # 返回
     * 完整的解决方案数组
     * @param {number} challenge_count
     * @returns {Uint32Array}
     */
    solve_all(challenge_count) {
        try {
            const retptr = wasm.__wbindgen_add_to_stack_pointer(-16);
            wasm.powsolver_solve_all(retptr, this.__wbg_ptr, challenge_count);
            var r0 = getDataViewMemory0().getInt32(retptr + 4 * 0, true);
            var r1 = getDataViewMemory0().getInt32(retptr + 4 * 1, true);
            var v1 = getArrayU32FromWasm0(r0, r1).slice();
            wasm.__wbindgen_export(r0, r1 * 4, 4);
            return v1;
        } finally {
            wasm.__wbindgen_add_to_stack_pointer(16);
        }
    }
}

if (Symbol.dispose) POWSolver.prototype[Symbol.dispose] = POWSolver.prototype.free;

/**
 * 独立函数：计算单个POW解决方案
 *
 * 不需要创建求解器实例的简化版本
 * @param {string} cap_id
 * @param {number} index
 * @param {number} difficulty
 * @returns {number}
 */
export function compute_pow_solution(cap_id, index, difficulty) {
    const ptr0 = passStringToWasm0(cap_id, wasm.__wbindgen_export2, wasm.__wbindgen_export3);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.compute_pow_solution(ptr0, len0, index, difficulty);
    return ret >>> 0;
}

/**
 * 获取WASM模块版本信息
 * @returns {string}
 */
export function get_version() {
    let deferred1_0;
    let deferred1_1;
    try {
        const retptr = wasm.__wbindgen_add_to_stack_pointer(-16);
        wasm.get_version(retptr);
        var r0 = getDataViewMemory0().getInt32(retptr + 4 * 0, true);
        var r1 = getDataViewMemory0().getInt32(retptr + 4 * 1, true);
        deferred1_0 = r0;
        deferred1_1 = r1;
        return getStringFromWasm0(r0, r1);
    } finally {
        wasm.__wbindgen_add_to_stack_pointer(16);
        wasm.__wbindgen_export(deferred1_0, deferred1_1, 1);
    }
}

/**
 * 测试函数：验证解决方案是否正确
 * @param {string} cap_id
 * @param {number} index
 * @param {number} solution
 * @param {number} difficulty
 * @returns {boolean}
 */
export function verify_solution(cap_id, index, solution, difficulty) {
    const ptr0 = passStringToWasm0(cap_id, wasm.__wbindgen_export2, wasm.__wbindgen_export3);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.verify_solution(ptr0, len0, index, solution, difficulty);
    return ret !== 0;
}

const EXPECTED_RESPONSE_TYPES = new Set(['basic', 'cors', 'default']);

async function __wbg_load(module, imports) {
    if (typeof Response === 'function' && module instanceof Response) {
        if (typeof WebAssembly.instantiateStreaming === 'function') {
            try {
                return await WebAssembly.instantiateStreaming(module, imports);
            } catch (e) {
                const validResponse = module.ok && EXPECTED_RESPONSE_TYPES.has(module.type);

                if (validResponse && module.headers.get('Content-Type') !== 'application/wasm') {
                    console.warn("`WebAssembly.instantiateStreaming` failed because your server does not serve Wasm with `application/wasm` MIME type. Falling back to `WebAssembly.instantiate` which is slower. Original error:\n", e);

                } else {
                    throw e;
                }
            }
        }

        const bytes = await module.arrayBuffer();
        return await WebAssembly.instantiate(bytes, imports);
    } else {
        const instance = await WebAssembly.instantiate(module, imports);

        if (instance instanceof WebAssembly.Instance) {
            return {instance, module};
        } else {
            return instance;
        }
    }
}

function __wbg_get_imports() {
    const imports = {};
    imports.wbg = {};
    imports.wbg.__wbg___wbindgen_throw_dd24417ed36fc46e = function (arg0, arg1) {
        throw new Error(getStringFromWasm0(arg0, arg1));
    };

    return imports;
}

function __wbg_finalize_init(instance, module) {
    wasm = instance.exports;
    __wbg_init.__wbindgen_wasm_module = module;
    cachedDataViewMemory0 = null;
    cachedUint32ArrayMemory0 = null;
    cachedUint8ArrayMemory0 = null;


    return wasm;
}

function initSync(module) {
    if (wasm !== undefined) return wasm;


    if (typeof module !== 'undefined') {
        if (Object.getPrototypeOf(module) === Object.prototype) {
            ({module} = module)
        } else {
            console.warn('using deprecated parameters for `initSync()`; pass a single object instead')
        }
    }

    const imports = __wbg_get_imports();
    if (!(module instanceof WebAssembly.Module)) {
        module = new WebAssembly.Module(module);
    }
    const instance = new WebAssembly.Instance(module, imports);
    return __wbg_finalize_init(instance, module);
}

async function __wbg_init(module_or_path) {
    if (wasm !== undefined) return wasm;


    if (typeof module_or_path !== 'undefined') {
        if (Object.getPrototypeOf(module_or_path) === Object.prototype) {
            ({module_or_path} = module_or_path)
        } else {
            console.warn('using deprecated parameters for the initialization function; pass a single object instead')
        }
    }

    if (typeof module_or_path === 'undefined') {
        module_or_path = new URL('pow_wasm_bg.wasm', import.meta.url);
    }
    const imports = __wbg_get_imports();

    if (typeof module_or_path === 'string' || (typeof Request === 'function' && module_or_path instanceof Request) || (typeof URL === 'function' && module_or_path instanceof URL)) {
        module_or_path = fetch(module_or_path);
    }

    const {instance, module} = await __wbg_load(await module_or_path, imports);

    return __wbg_finalize_init(instance, module);
}

export {initSync};
export default __wbg_init;
