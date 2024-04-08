package net.wg.data.constants
{
   public class UserTags
   {
      
      public static const FRIEND:String = "friend";
      
      public static const IGNORED:String = "ignored";
      
      public static const IGNORED_TMP:String = "tmp_ignored";
      
      public static const MUTED:String = "muted";
      
      public static const CURRENT:String = "himself";
      
      public static const IGR_BASE:String = "igr/base";
      
      public static const IGR_PREMIUM:String = "igr/premium";
      
      public static const PRESENCE_DND:String = "presence/dnd";
      
      public static const SUB_TO:String = "sub/to";
      
      public static const SUB_PENDING_IN:String = "sub/pendingIn";
      
      public static const BAN_CHAT:String = "ban/chat";
       
      
      public function UserTags()
      {
         super();
      }
      
      public static function isFriend(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(FRIEND) != -1;
      }
      
      public static function isIgnored(param1:Array) : Boolean
      {
         return param1 && (param1.indexOf(IGNORED) != -1 || param1.indexOf(IGNORED_TMP) != -1);
      }
      
      public static function isIgnoredTmp(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(IGNORED_TMP) != -1;
      }
      
      public static function isMuted(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(MUTED) != -1;
      }
      
      public static function isCurrentPlayer(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(CURRENT) != -1;
      }
      
      public static function isBusy(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(PRESENCE_DND) != -1;
      }
      
      public static function isBaseIGR(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(IGR_BASE) != -1;
      }
      
      public static function isPremiumIGR(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(IGR_PREMIUM) != -1;
      }
      
      public static function isInIGR(param1:Array) : Boolean
      {
         return isBaseIGR(param1) || isPremiumIGR(param1);
      }
      
      public static function isChatBan(param1:Array) : Boolean
      {
         return param1 && param1.indexOf(BAN_CHAT) != -1;
      }
   }
}
