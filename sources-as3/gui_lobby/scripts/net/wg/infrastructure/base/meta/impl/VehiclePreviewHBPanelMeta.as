package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPHBBuyingPanelVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewHBPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var onAcceptClicked:Function;
      
      public var onSecondaryClicked:Function;
      
      public var showTooltip:Function;
      
      private var _vPHBBuyingPanelVO:VPHBBuyingPanelVO;
      
      public function VehiclePreviewHBPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPHBBuyingPanelVO)
         {
            this._vPHBBuyingPanelVO.dispose();
            this._vPHBBuyingPanelVO = null;
         }
         super.onDispose();
      }
      
      public function onAcceptClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onAcceptClicked,"onAcceptClicked" + Errors.CANT_NULL);
         this.onAcceptClicked();
      }
      
      public function onSecondaryClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onSecondaryClicked,"onSecondaryClicked" + Errors.CANT_NULL);
         this.onSecondaryClicked();
      }
      
      public function showTooltipS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.showTooltip,"showTooltip" + Errors.CANT_NULL);
         this.showTooltip(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPHBBuyingPanelVO = this._vPHBBuyingPanelVO;
         this._vPHBBuyingPanelVO = new VPHBBuyingPanelVO(param1);
         this.setData(this._vPHBBuyingPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPHBBuyingPanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
