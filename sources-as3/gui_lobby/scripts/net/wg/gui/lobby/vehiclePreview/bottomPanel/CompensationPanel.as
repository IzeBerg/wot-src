package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehiclePreview.data.VPCompensationVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CompensationPanel extends UIComponentEx
   {
      
      private static const MAX_TOOLTIP_WIDTH:Number = 350;
       
      
      public var iconInfo:Image = null;
      
      public var descriptionTF:TextField = null;
      
      public var valueTF:TextField = null;
      
      private var _data:VPCompensationVO = null;
      
      public function CompensationPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.iconInfo.addEventListener(MouseEvent.MOUSE_OVER,this.onIconInfoMouseOverHandler);
         this.iconInfo.addEventListener(MouseEvent.MOUSE_OUT,this.onIconInfoMouseOutHandler);
         this.iconInfo.addEventListener(Event.CHANGE,this.onIconInfoLoadHandler);
         this.descriptionTF.mouseWheelEnabled = this.descriptionTF.mouseEnabled = false;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.valueTF.mouseWheelEnabled = this.valueTF.mouseEnabled = false;
         this.valueTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.iconInfo.source = this._data.iconInfo;
            this.descriptionTF.text = this._data.description;
            this.valueTF.htmlText = this._data.value;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.iconInfo.x + this.iconInfo.width;
            this.descriptionTF.x = _loc1_;
            this.valueTF.x = _loc1_ + this.descriptionTF.textWidth;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconInfo.removeEventListener(MouseEvent.MOUSE_OVER,this.onIconInfoMouseOverHandler);
         this.iconInfo.removeEventListener(MouseEvent.MOUSE_OUT,this.onIconInfoMouseOutHandler);
         this.iconInfo.removeEventListener(Event.CHANGE,this.onIconInfoLoadHandler);
         this.iconInfo.dispose();
         this.iconInfo = null;
         this.descriptionTF = null;
         this.valueTF = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:VPCompensationVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onIconInfoLoadHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onIconInfoMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onIconInfoMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ITooltipProps = App.toolTipMgr.getDefaultTooltipProps();
         _loc2_ = ITooltipProps(_loc2_.clone());
         _loc2_.maxWidth = MAX_TOOLTIP_WIDTH;
         App.toolTipMgr.showComplex(this._data.tooltip,_loc2_);
      }
   }
}
