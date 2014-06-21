package com.baihui.hxtd.soa.base;

import javax.xml.ws.WebFault;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;

/**
 * 自定义服务异常
 */
@WebFault(name = "ServiceFault")
public class ServiceException extends Exception {

    private static final long serialVersionUID = -3352732902889471110L;

	/*
     * Validator Errors
	 * 
	 * 格式错误代码(268435456~536870911)
	 */
    /**
     * 不明类型的格式错误
     */
    public static final int VALIDATE_ERROR = 0x10000000;

    public static final String VALIDATE_ERROR_MESSAGE = "参数校验错误";

    /**
     * 参数为空
     */
    public static final int VALIDATE_PARAM_NULL = 0x10000001;

    public static final String VALIDATE_PARAM_NULL_MESSAGE = "内容为空";

    /**
     * 参数转换错误
     */
    public static final int VALIDATE_FORMAT_ERROR = 0x10000002;

    public static final String VALIDATE_FORMAT_ERROR_MESSAGE = "格式错误";

    /**
     * 参数区间错误
     */
    public static final int VALIDATE_RANGE_ERROR = 0x10000003;

    public static final String VALIDATE_RANGE_ERROR_MESSAGE = "输入区间错误";

    /**
     * 时间格式错误
     */
    public static final int VALIDATE_DATE_FORMAT_ERROR = 0x10000004;

    /**
     * 参数不完整
     */
    public static final int VALIDATE_PARAM_NOT_COMPLETE = 0x10000005;

    /**
     * 手机号格式错误
     */
    public static final int VALIDATE_PHONENO_FORMAT_ERROR = 0x10000006;

	/*
	 * Permission Errors
	 * 
	 * 业务错误代码(536870912~805306367)
	 */
    /**
     * 不明类型的业务错误
     */
    public static final int PERMISSION_ERROR = 0x20000000;

    /**
     * 异常代码
     */
    private int errorCode;

    public ServiceException(Exception e) {
        super(e);
        this.errorCode = PERMISSION_ERROR;
    }

    /**
     * 创建一个自定义异常。
     *
     * @param errorCode 异常代码，具体定义见本类的常量
     */
    public ServiceException(int errorCode) {
        this.errorCode = errorCode;
    }

    /**
     * 创建一个自定义异常
     *
     * @param errorCode 异常代码
     * @param message   异常信息
     */
    public ServiceException(int errorCode, String message) {
        super(Integer.toHexString(errorCode).toString().toUpperCase()
                + " - " + message);
        this.errorCode = errorCode;
    }

    /**
     * 获取异常代码
     *
     * @return
     */
    public int getErrorCode() {
        return errorCode;
    }

    /**
     * 设定异常代码
     *
     * @param errorCode
     */
    public void setErrorCode(int errorCode) {
        this.errorCode = errorCode;
    }

    /**
     * 获取当前ServiceException的trace信息
     *
     * @return
     */
    public String getTrace() {
        ByteArrayOutputStream byteArrayOutputStream = null;
        String trace = null;
        try {
            byteArrayOutputStream = new ByteArrayOutputStream();
            printStackTrace(new PrintStream(byteArrayOutputStream));
            trace = byteArrayOutputStream.toString();
        } finally {
            if (byteArrayOutputStream != null) {
                try {
                    byteArrayOutputStream.close();
                } catch (IOException e) {

                }
            }
        }
        return trace;
    }
}