package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class GameMessagesPanelMeta extends BattleDisplayable
   {
       
      
      public var onMessageStarted:Function;
      
      public var onMessagePhaseStarted:Function;
      
      public var onMessageEnded:Function;
      
      public var onMessageHiding:Function;
      
      private var _gameMessageVO:GameMessageVO;
      
      public function GameMessagesPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._gameMessageVO)
         {
            this._gameMessageVO.dispose();
            this._gameMessageVO = null;
         }
         super.onDispose();
      }
      
      public function onMessageStartedS(param1:String, param2:String, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageStarted,"onMessageStarted" + Errors.CANT_NULL);
         this.onMessageStarted(param1,param2,param3);
      }
      
      public function onMessagePhaseStartedS(param1:String, param2:String, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMessagePhaseStarted,"onMessagePhaseStarted" + Errors.CANT_NULL);
         this.onMessagePhaseStarted(param1,param2,param3);
      }
      
      public function onMessageEndedS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageEnded,"onMessageEnded" + Errors.CANT_NULL);
         this.onMessageEnded(param1,param2);
      }
      
      public function onMessageHidingS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageHiding,"onMessageHiding" + Errors.CANT_NULL);
         this.onMessageHiding(param1,param2);
      }
      
      public final function as_addMessage(param1:Object) : void
      {
         var _loc2_:GameMessageVO = this._gameMessageVO;
         this._gameMessageVO = new GameMessageVO(param1);
         this.addMessage(this._gameMessageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function addMessage(param1:GameMessageVO) : void
      {
         var _loc2_:String = "as_addMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
