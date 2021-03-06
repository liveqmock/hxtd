package com.baihui.hxtd.soa.base.utils.serial;

/**
 * 在当前节点下不允许再有子节点
 */
public class NoChildAllowedException extends RuntimeException {

	private static final long serialVersionUID = -3217821688820939280L;

	public NoChildAllowedException() {
        super("在当前节点下不允许再有子节点");
    }

    public NoChildAllowedException(String message) {
        super(message);
    }

    public NoChildAllowedException(String message, Throwable cause) {
        super(message, cause);
    }

    public NoChildAllowedException(Throwable cause) {
        super(cause);
    }
}
