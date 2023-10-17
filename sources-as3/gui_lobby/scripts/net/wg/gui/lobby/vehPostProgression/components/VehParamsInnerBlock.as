package net.wg.gui.lobby.vehPostProgression.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.hangar.VehicleParametersWithHighlight;
   import net.wg.gui.lobby.vehPostProgression.events.DemountAllBtnEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class VehParamsInnerBlock extends UIComponentEx
   {
      
      private static const BTN_DEMOUNT_TOP_OFFSET:int = 30;
       
      
      public var demountAllButton:SoundButtonEx = null;
      
      public var params:VehicleParametersWithHighlight = null;
      
      public var bg:Sprite = null;
      
      private var _showDemountAllPairsBtn:Boolean = false;
      
      private var _showBottomShadowLipAlways:Boolean = false;
      
      public function VehParamsInnerBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.demountAllButton.removeEventListener(MouseEvent.CLICK,this.onDemountAllButtonClickHandler);
         this.demountAllButton.dispose();
         this.demountAllButton = null;
         this.params.removeEventListener(Event.RESIZE,this.onParamsResizeHandler);
         this.params = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.demountAllButton.visible = this._showDemountAllPairsBtn;
            this.params.showBottomShadowLipAlways = this._showBottomShadowLipAlways;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateDemountAllBtnPosition();
            this.bg.height = _height;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.params.showShadowLipWhenOverflow = true;
         this.params.snapHeightToRenderers = false;
         this.params.hideBg();
         this.params.forceInvalidateOnDataChange = true;
         this.params.addEventListener(Event.RESIZE,this.onParamsResizeHandler);
         this.demountAllButton.useHtmlText = true;
         this.demountAllButton.addEventListener(MouseEvent.CLICK,this.onDemountAllButtonClickHandler);
         this.demountAllButton.tooltip = VEH_POST_PROGRESSION.VEHPOSTPROGRESSIONVIEW_BUTTON_DEMOUNTALLPAIRS_TOOLTIP;
      }
      
      public function setDemountAllButtonLabel(param1:String) : void
      {
         this.demountAllButton.label = param1;
      }
      
      private function updateDemountAllBtnPosition() : void
      {
         this.demountAllButton.y = this.params.y + this.params.paramsList.height + BTN_DEMOUNT_TOP_OFFSET;
      }
      
      public function set showBottomShadowLipAlways(param1:Boolean) : void
      {
         this._showBottomShadowLipAlways = param1;
      }
      
      public function set showDemountAllPairsBtn(param1:Boolean) : void
      {
         this._showDemountAllPairsBtn = param1;
         invalidateData();
      }
      
      private function onDemountAllButtonClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new DemountAllBtnEvent(DemountAllBtnEvent.DEMOUNT_ALL_CLICK,true));
         }
      }
      
      private function onParamsResizeHandler(param1:Event) : void
      {
         this.updateDemountAllBtnPosition();
      }
   }
}
