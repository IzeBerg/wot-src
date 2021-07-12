package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class VoiceChatManagerMeta extends BaseDAAPIModule
   {
       
      
      public var isPlayerSpeaking:Function;
      
      public var isVivox:Function;
      
      public var isYY:Function;
      
      public var isVOIPEnabled:Function;
      
      public function VoiceChatManagerMeta()
      {
         super();
      }
      
      public function isPlayerSpeakingS(param1:Number) : Boolean
      {
         App.utils.asserter.assertNotNull(this.isPlayerSpeaking,"isPlayerSpeaking" + Errors.CANT_NULL);
         return this.isPlayerSpeaking(param1);
      }
      
      public function isVivoxS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isVivox,"isVivox" + Errors.CANT_NULL);
         return this.isVivox();
      }
      
      public function isYYS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isYY,"isYY" + Errors.CANT_NULL);
         return this.isYY();
      }
      
      public function isVOIPEnabledS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isVOIPEnabled,"isVOIPEnabled" + Errors.CANT_NULL);
         return this.isVOIPEnabled();
      }
   }
}
