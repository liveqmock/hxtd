package com.baihui.hxtd.soa.base.utils.serial;

/**
 * 超过当前层次所能容纳的值
 */
public class OverSerialTierContentException extends RuntimeException {

    
	private static final long serialVersionUID = 3323949769333652516L;

	public OverSerialTierContentException() {
        super("超过当前层次所能容纳的值");
    }

    public OverSerialTierContentException(String message) {
        super(message);
    }

    public OverSerialTierContentException(int actual, int min, int max) {
        super("超过当前层次所能容纳的值，期待范围在" + min + "~" + max + "之间，实际值" + actual);
    }

    public OverSerialTierContentException(String message, Throwable cause) {
        super(message, cause);
    }

    public OverSerialTierContentException(Throwable cause) {
        super(cause);
    }
}
