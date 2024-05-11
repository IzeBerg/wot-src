package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battlequeue.BattleStrongholdsLeaguesVO;
   import net.wg.gui.lobby.battlequeue.BattleStrongholdsQueueTypeInfoVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleStrongholdsQueueMeta extends AbstractView
   {
       
      
      public var exitClick:Function;
      
      public var onEscape:Function;
      
      private var _battleStrongholdsQueueTypeInfoVO:BattleStrongholdsQueueTypeInfoVO;
      
      private var _battleStrongholdsLeaguesVO:BattleStrongholdsLeaguesVO;
      
      public function BattleStrongholdsQueueMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleStrongholdsQueueTypeInfoVO)
         {
            this._battleStrongholdsQueueTypeInfoVO.dispose();
            this._battleStrongholdsQueueTypeInfoVO = null;
         }
         if(this._battleStrongholdsLeaguesVO)
         {
            this._battleStrongholdsLeaguesVO.dispose();
            this._battleStrongholdsLeaguesVO = null;
         }
         super.onDispose();
      }
      
      public function exitClickS() : void
      {
         App.utils.asserter.assertNotNull(this.exitClick,"exitClick" + Errors.CANT_NULL);
         this.exitClick();
      }
      
      public function onEscapeS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
      
      public final function as_setTypeInfo(param1:Object) : void
      {
         var _loc2_:BattleStrongholdsQueueTypeInfoVO = this._battleStrongholdsQueueTypeInfoVO;
         this._battleStrongholdsQueueTypeInfoVO = new BattleStrongholdsQueueTypeInfoVO(param1);
         this.setTypeInfo(this._battleStrongholdsQueueTypeInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setLeagues(param1:Object) : void
      {
         var _loc2_:BattleStrongholdsLeaguesVO = this._battleStrongholdsLeaguesVO;
         this._battleStrongholdsLeaguesVO = new BattleStrongholdsLeaguesVO(param1);
         this.setLeagues(this._battleStrongholdsLeaguesVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setTypeInfo(param1:BattleStrongholdsQueueTypeInfoVO) : void
      {
         var _loc2_:String = "as_setTypeInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setLeagues(param1:BattleStrongholdsLeaguesVO) : void
      {
         var _loc2_:String = "as_setLeagues" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
