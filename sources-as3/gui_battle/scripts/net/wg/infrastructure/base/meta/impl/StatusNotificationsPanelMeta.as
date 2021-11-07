package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationsPanelInitVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StatusNotificationsPanelMeta extends BattleDisplayable
   {
       
      
      private var _statusNotificationsPanelInitVO:StatusNotificationsPanelInitVO;
      
      private var _vectorStatusNotificationVO:Vector.<StatusNotificationVO>;
      
      public function StatusNotificationsPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:StatusNotificationVO = null;
         if(this._statusNotificationsPanelInitVO)
         {
            this._statusNotificationsPanelInitVO.dispose();
            this._statusNotificationsPanelInitVO = null;
         }
         if(this._vectorStatusNotificationVO)
         {
            for each(_loc1_ in this._vectorStatusNotificationVO)
            {
               _loc1_.dispose();
            }
            this._vectorStatusNotificationVO.splice(0,this._vectorStatusNotificationVO.length);
            this._vectorStatusNotificationVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:StatusNotificationsPanelInitVO = this._statusNotificationsPanelInitVO;
         this._statusNotificationsPanelInitVO = new StatusNotificationsPanelInitVO(param1);
         this.setInitData(this._statusNotificationsPanelInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setData(param1:Array) : void
      {
         var _loc5_:StatusNotificationVO = null;
         var _loc2_:Vector.<StatusNotificationVO> = this._vectorStatusNotificationVO;
         this._vectorStatusNotificationVO = new Vector.<StatusNotificationVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorStatusNotificationVO[_loc4_] = new StatusNotificationVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setData(this._vectorStatusNotificationVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setInitData(param1:StatusNotificationsPanelInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:Vector.<StatusNotificationVO>) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
