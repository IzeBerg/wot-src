package net.wg.infrastructure.managers.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.impl.VoiceChatManagerMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   
   public class VoiceChatManagerBase extends VoiceChatManagerMeta implements IVoiceChatManager
   {
       
      
      private var _isYYReceived:Boolean = false;
      
      private var _isYY:Boolean = false;
      
      public function VoiceChatManagerBase()
      {
         super();
      }
      
      public function getYY() : Boolean
      {
         if(!this._isYYReceived)
         {
            this._isYYReceived = true;
            this._isYY = isYYS();
         }
         return this._isYY;
      }
      
      public function as_onPlayerSpeak(param1:Number, param2:Boolean, param3:Boolean) : void
      {
         throw new AbstractException("VoiceChatManagerBase.as_onPlayerSpeak" + Errors.ABSTRACT_INVOKE);
      }
   }
}
