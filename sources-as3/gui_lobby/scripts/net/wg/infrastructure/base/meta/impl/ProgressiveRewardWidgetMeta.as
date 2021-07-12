package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProgressiveRewardWidgetMeta extends BaseDAAPIComponent
   {
       
      
      public var onWidgetClick:Function;
      
      public var onOpenBtnClick:Function;
      
      private var _progressiveRewardVO:ProgressiveRewardVO;
      
      public function ProgressiveRewardWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._progressiveRewardVO)
         {
            this._progressiveRewardVO.dispose();
            this._progressiveRewardVO = null;
         }
         super.onDispose();
      }
      
      public function onWidgetClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onWidgetClick,"onWidgetClick" + Errors.CANT_NULL);
         this.onWidgetClick();
      }
      
      public function onOpenBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onOpenBtnClick,"onOpenBtnClick" + Errors.CANT_NULL);
         this.onOpenBtnClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ProgressiveRewardVO = this._progressiveRewardVO;
         this._progressiveRewardVO = new ProgressiveRewardVO(param1);
         this.setData(this._progressiveRewardVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:ProgressiveRewardVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
