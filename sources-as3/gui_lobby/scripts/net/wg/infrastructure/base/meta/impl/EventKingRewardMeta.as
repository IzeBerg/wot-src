package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPEventKingRewardVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventKingRewardMeta extends BaseDAAPIComponent
   {
       
      
      public var onExitToRewardsClick:Function;
      
      private var _vPEventKingRewardVO:VPEventKingRewardVO;
      
      public function EventKingRewardMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPEventKingRewardVO)
         {
            this._vPEventKingRewardVO.dispose();
            this._vPEventKingRewardVO = null;
         }
         super.onDispose();
      }
      
      public function onExitToRewardsClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onExitToRewardsClick,"onExitToRewardsClick" + Errors.CANT_NULL);
         this.onExitToRewardsClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPEventKingRewardVO = this._vPEventKingRewardVO;
         this._vPEventKingRewardVO = new VPEventKingRewardVO(param1);
         this.setData(this._vPEventKingRewardVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPEventKingRewardVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
