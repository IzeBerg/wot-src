package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.messages.MessageList;
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleMessageListMeta extends MessageList
   {
       
      
      public var onRefreshComplete:Function;
      
      private var _fadingMessageListSettingsVO:FadingMessageListSettingsVO;
      
      public function BattleMessageListMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._fadingMessageListSettingsVO)
         {
            this._fadingMessageListSettingsVO.dispose();
            this._fadingMessageListSettingsVO = null;
         }
         super.onDispose();
      }
      
      public function onRefreshCompleteS() : void
      {
         App.utils.asserter.assertNotNull(this.onRefreshComplete,"onRefreshComplete" + Errors.CANT_NULL);
         this.onRefreshComplete();
      }
      
      public final function as_setupList(param1:Object) : void
      {
         var _loc2_:FadingMessageListSettingsVO = this._fadingMessageListSettingsVO;
         this._fadingMessageListSettingsVO = new FadingMessageListSettingsVO(param1);
         this.setupList(this._fadingMessageListSettingsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setupList(param1:FadingMessageListSettingsVO) : void
      {
         var _loc2_:String = "as_setupList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
