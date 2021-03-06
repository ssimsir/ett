package com.ett.common.util;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Generics鐨剈til绫�.
 *
 * @author sshwsfc from springside
 */
@SuppressWarnings("unchecked")
public class GenericUtil {
	private static final Log log = LogFactory.getLog(GenericUtil.class);

	private GenericUtil() {
	}

	/**
	 * 閫氳繃鍙嶅皠,鑾峰緱瀹氫箟Class鏃跺０鏄庣殑鐖剁被鐨勮寖鍨嬪弬鏁扮殑绫诲瀷. 濡俻ublic BookManager extends GenricManager<Book>
	 *
	 * @param clazz The class to introspect
	 * @return the first generic declaration, or <code>Object.class</code> if cannot be determined
	 */

	public static Class getSuperClassGenricType(Class clazz) {
		return getSuperClassGenricType(clazz, 0);
	}

	/**
	 * 閫氳繃鍙嶅皠,鑾峰緱瀹氫箟Class鏃跺０鏄庣殑鐖剁被鐨勮寖鍨嬪弬鏁扮殑绫诲瀷. 濡俻ublic BookManager extends GenricManager<Book>
	 *
	 * @param clazz clazz The class to introspect
	 * @param index the Index of the generic ddeclaration,start from 0.
	 * @return the index generic declaration, or <code>Object.class</code> if cannot be determined
	 */
	public static Class getSuperClassGenricType(Class clazz, int index) {

		Type genType = clazz.getGenericSuperclass();

		if (!(genType instanceof ParameterizedType)) {
			log.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
			return Object.class;
		}

		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

		if (index >= params.length || index < 0) {
			log.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: "
					+ params.length);
			return Object.class;
		}
		if (!(params[index] instanceof Class)) {
			log.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
			return Object.class;
		}
		return (Class) params[index];
	}
}
