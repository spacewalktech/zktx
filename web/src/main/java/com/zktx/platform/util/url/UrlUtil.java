package com.zktx.platform.util.url;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
//import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
//import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;

public class UrlUtil {

	public static String doPost(String url, Map<String, String> map) throws Throwable {
		// 创建client
		CloseableHttpClient httpclient = getClient();
		// 创建GET请求
		HttpGet httpGet = new HttpGet(url);
		// 头信息
		setHeaders(httpGet);
		// 添加参数
		setParameter(map, httpGet);
		// 返回数据
		return getResult(httpclient, httpGet);
	}
	
	/**
	 * 创建忽略证书的Client
	 */
	private static CloseableHttpClient getClient() throws Exception {
		SSLContextBuilder builder = new SSLContextBuilder();
		builder.loadTrustMaterial(null, new TrustSelfSignedStrategy());
		// SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(builder.build(), SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(builder.build());
		// 忽略证书
		Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory> create()//
				.register("http", new PlainConnectionSocketFactory())//
				.register("https", sslsf).build();//
		PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager(registry);
		cm.setMaxTotal(9999);
		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).setConnectionManager(cm).build();
		return httpclient;
	}
	
	/**
	 * 添加头信息
	 */
	private static void setHeaders(HttpGet httpGet) {
		httpGet.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
		httpGet.addHeader("Accept-Encoding", "gzip, deflate, sdch");
		httpGet.addHeader("Accept-Language", "zh-CN,zh;q=0.8,en;q=0.6");
		httpGet.addHeader("Connection", "keep-alive");
//		httpGet.addHeader("Content-Type", "application/x-www-form-urlencoded");
		httpGet.addHeader("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36");
	}

	/**
	 * 设置代理
	 */
	/*private static <T extends HttpRequestBase> void setProxy(T httpGet) {
		HttpHost proxy = new HttpHost("123.56.251.212", 8123);
		RequestConfig config = RequestConfig.custom().setProxy(proxy).build();
		httpGet.addHeader("Proxy-Authorization", GetHttpIp.getIp());
		httpGet.setConfig(config);
	}*/
	
	/**
	 * 添加参数
	 * 
	 */
	private static void setParameter(Map<String, String> hashMap, HttpGet httpGet) {
		List<String> list = new ArrayList<String>();
		if (hashMap != null) {
			Iterator<String> it = hashMap.keySet().iterator();
			while (it.hasNext()) {
				String key = it.next();
				String value = hashMap.get(key);
				list.add(key + "=" + value);
			}
		}
		try {
			//httpGet.setEntity(new StringEntity(StringUtils.join(list, "&"), "UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 请求
	 * 
	 * @param httpclient
	 * @param httpGet
	 * @return
	 * @param
	 * @throws Throwable 
	 */
	private static String getResult(CloseableHttpClient httpclient, HttpGet httpGet) throws Throwable {
		CloseableHttpResponse response = httpclient.execute(httpGet);
		try {
			String result = EntityUtils.toString(response.getEntity(), "UTF-8");
			return result;
		} finally {
			response.close();
			httpclient.close();
		}
	}
	
}
