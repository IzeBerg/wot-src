package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class Comp7PlayersPanelMeta extends PlayersPanel
   {
       
      
      public var onVoiceChatControlClick:Function;
      
      private var _voiceChatActivationVO:VoiceChatActivationVO;
      
      public function Comp7PlayersPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._voiceChatActivationVO)
         {
            this._voiceChatActivationVO.dispose();
            this._voiceChatActivationVO = null;
         }
         super.onDispose();
      }
      
      public function onVoiceChatControlClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onVoiceChatControlClick,"onVoiceChatControlClick" + Errors.CANT_NULL);
         this.onVoiceChatControlClick();
      }
      
      public final function as_setVoiceChatData(param1:Object) : void
      {
         var _loc2_:VoiceChatActivationVO = this._voiceChatActivationVO;
         this._voiceChatActivationVO = new VoiceChatActivationVO(param1);
         this.setVoiceChatData(this._voiceChatActivationVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVoiceChatData(param1:VoiceChatActivationVO) : void
      {
         var _loc2_:String = "as_setVoiceChatData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
