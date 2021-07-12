package scaleform.clik.utils
{
   import flash.external.ExternalInterface;
   
   public class GameCenterInterface
   {
      
      public static var _loginUser:Function;
      
      public static var _openLeaderboardPane:Function;
      
      public static var _setLeaderboardScore:Function;
      
      public static var _openAchievementPane:Function;
      
      public static var _setAchievementCompletion:Function;
      
      public static var _resetAchievements:Function;
      
      public static var _receiveOnlineResult:Function;
       
      
      public function GameCenterInterface()
      {
         super();
      }
      
      public static function init() : void
      {
         ExternalInterface.call("GameCenterInterface.init",GameCenterInterface);
      }
      
      public static function loginUser() : void
      {
         _loginUser();
      }
      
      public static function openLeaderboardPane() : void
      {
         _openLeaderboardPane();
      }
      
      public static function setLeaderboardScore(param1:String, param2:Number) : void
      {
         _setLeaderboardScore(param1,param2);
      }
      
      public static function openAchievementPane() : void
      {
         _openAchievementPane();
      }
      
      public static function setAchievementCompletion(param1:String, param2:Number) : void
      {
         _setAchievementCompletion(param1,param2);
      }
      
      public static function resetAchievements() : Boolean
      {
         return _resetAchievements();
      }
      
      public static function receiveOnlineResult() : Boolean
      {
         return _receiveOnlineResult();
      }
   }
}
