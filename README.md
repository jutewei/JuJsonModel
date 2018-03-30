OC网络json数据转模型，zip包中工具可实现转换并生成相应的类

1、数组、字典转模型

具体使用

/**
 *  @author Juvid, 15-07-15 10:07:34
 *
 *  网络获取数据转对象数组
 *
 *  @param arr 网络返回的数组包含相同的字典
 *
 *  @return 返回转换好的数组，数组里为对象
 */
 
+(NSArray *) setArrayForModel :(NSArray *) arr ;

/**
 *  @author Juvid, 15-07-15 10:07:29
 *
 *  网络获取数据转对象
 *
 *  @param dic 网络返回的字典
 *
 *  @return 返回转换好的对象
 */
+(id) setDictionaryForModel :(NSDictionary *) dic ;

-(id) setDictionaryForModel :(NSDictionary *) dic;


2、模型转数组或字典
//对象转换成字典
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象转换成字典包括父对象
 *
 *  @param baseModel 转换的对象
 *
 *  @return 返回字典
 */
+(NSMutableDictionary *) setModelForDictionary :(id) baseModel;
//对象数组转换成数字
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象数组转换成字符数组
 *
 *  @param baseModel 转换的对象
 *
 *  @return 返回字典
 */
+(NSArray *) setModelForArray :(NSArray *) arr;
