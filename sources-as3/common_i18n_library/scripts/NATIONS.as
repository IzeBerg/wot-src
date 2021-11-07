package
{
   public class NATIONS
   {
      
      public static const USSR:String = "#nations:ussr";
      
      public static const GERMANY:String = "#nations:germany";
      
      public static const USA:String = "#nations:usa";
      
      public static const FRANCE:String = "#nations:france";
      
      public static const UK:String = "#nations:uk";
      
      public static const JAPAN:String = "#nations:japan";
      
      public static const CZECH:String = "#nations:czech";
      
      public static const CHINA:String = "#nations:china";
      
      public static const POLAND:String = "#nations:poland";
      
      public static const SWEDEN:String = "#nations:sweden";
      
      public static const ITALY:String = "#nations:italy";
      
      public static const USSR_GENETIVECASE:String = "#nations:ussr/genetiveCase";
      
      public static const GERMANY_GENETIVECASE:String = "#nations:germany/genetiveCase";
      
      public static const USA_GENETIVECASE:String = "#nations:usa/genetiveCase";
      
      public static const CHINA_GENETIVECASE:String = "#nations:china/genetiveCase";
      
      public static const FRANCE_GENETIVECASE:String = "#nations:france/genetiveCase";
      
      public static const UK_GENETIVECASE:String = "#nations:uk/genetiveCase";
      
      public static const JAPAN_GENETIVECASE:String = "#nations:japan/genetiveCase";
      
      public static const CZECH_GENETIVECASE:String = "#nations:czech/genetiveCase";
      
      public static const SWEDEN_GENETIVECASE:String = "#nations:sweden/genetiveCase";
      
      public static const POLAND_GENETIVECASE:String = "#nations:poland/genetiveCase";
      
      public static const ITALY_GENETIVECASE:String = "#nations:italy/genetiveCase";
      
      public static const ALL_GENETIVECASE_ENUM:Array = [USSR_GENETIVECASE,GERMANY_GENETIVECASE,USA_GENETIVECASE,CHINA_GENETIVECASE,FRANCE_GENETIVECASE,UK_GENETIVECASE,JAPAN_GENETIVECASE,CZECH_GENETIVECASE,SWEDEN_GENETIVECASE,POLAND_GENETIVECASE,ITALY_GENETIVECASE];
      
      public static const ALL_ENUM:Array = [USSR,GERMANY,USA,FRANCE,UK,JAPAN,CZECH,CHINA,POLAND,SWEDEN,ITALY,USSR_GENETIVECASE,GERMANY_GENETIVECASE,USA_GENETIVECASE,CHINA_GENETIVECASE,FRANCE_GENETIVECASE,UK_GENETIVECASE,JAPAN_GENETIVECASE,CZECH_GENETIVECASE,SWEDEN_GENETIVECASE,POLAND_GENETIVECASE,ITALY_GENETIVECASE];
       
      
      public function NATIONS()
      {
         super();
      }
      
      public static function genetiveCase(param1:String) : String
      {
         var _loc2_:String = "#nations:" + param1 + "/genetiveCase";
         if(ALL_GENETIVECASE_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[genetiveCase]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function all(param1:String) : String
      {
         var _loc2_:String = "#nations:" + param1;
         if(ALL_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[all]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
   }
}
