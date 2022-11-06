package net.wg.data.constants
{
   public class InvitationStatus
   {
      
      public static const NONE:uint = 0;
      
      public static const FORBIDDEN_BY_RECEIVER:uint = 1;
      
      public static const FORBIDDEN_BY_SENDER:uint = 2;
      
      public static const RECEIVED_FROM:uint = 4;
      
      public static const RECEIVED_INACTIVE:uint = 8;
      
      public static const SENT_TO:uint = 16;
      
      public static const SENT_INACTIVE:uint = 32;
      
      public static const SPG_IS_FORBIDDEN:uint = 64;
       
      
      public function InvitationStatus()
      {
         super();
      }
      
      public static function isForbidden(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.FORBIDDEN_BY_RECEIVER) > 0 || (param1 & InvitationStatus.FORBIDDEN_BY_SENDER) > 0 || (param1 & InvitationStatus.SPG_IS_FORBIDDEN) > 0;
      }
      
      public static function isReceived(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.RECEIVED_FROM) > 0;
      }
      
      public static function isOnlyReceived(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.RECEIVED_FROM) > 0 && (param1 & InvitationStatus.RECEIVED_INACTIVE) == 0;
      }
      
      public static function isReceivedInactive(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.RECEIVED_INACTIVE) > 0;
      }
      
      public static function isSent(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.SENT_TO) > 0;
      }
      
      public static function isSentInactive(param1:uint) : Boolean
      {
         return (param1 & InvitationStatus.SENT_INACTIVE) > 0;
      }
   }
}
