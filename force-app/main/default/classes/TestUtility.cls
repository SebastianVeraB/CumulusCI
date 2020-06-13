public class TestUtility
{
   static Integer s_num = 1;

   public static String getFakeId(Schema.SObjectType sobjectType, String variation)
   {
      String result = String.valueOf(s_num++);
      return sobjectType.getDescribe().getKeyPrefix() + 
         variation.repeat(12-result.length()) + result;
   }
}