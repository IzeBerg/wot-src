package net.wg.gui.lobby.vehiclePreview.packItemsPopover
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.SLOT_HIGHLIGHT_TYPES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPPackItemVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class PackItemRenderer extends TableRenderer
   {
      
      private static const CHECK_ICON_OFFSET:int = 15;
       
      
      public var valueTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var checkIcon:MovieClip = null;
      
      public var icon:Image = null;
      
      public var overlayType:MovieClip;
      
      private var _itemData:VPPackItemVO = null;
      
      public function PackItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.wordWrap = true;
         this.descriptionTF.multiline = true;
         this.descriptionTF.mouseWheelEnabled = this.descriptionTF.mouseEnabled = false;
         this.valueTF.mouseWheelEnabled = this.valueTF.mouseEnabled = false;
         this.checkIcon.mouseEnabled = this.checkIcon.mouseChildren = false;
         this.overlayType.mouseEnabled = this.overlayType.mouseChildren = false;
         preventAutoSizingBg = true;
         buttonMode = false;
         this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override public function set mouseChildren(param1:Boolean) : void
      {
         super.mouseChildren = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._itemData != null && isInvalid(InvalidationType.DATA))
         {
            if(this._itemData.value)
            {
               this.valueTF.text = this._itemData.value;
               this.valueTF.visible = true;
            }
            else
            {
               this.valueTF.visible = false;
            }
            this.descriptionTF.htmlText = this._itemData.description;
            this.icon.source = this._itemData.icon;
            this.icon.alpha = !!this._itemData.hasCompensation ? Number(0.5) : Number(1);
            this.checkIcon.visible = this._itemData.hasCompensation;
            this.overlayType.visible = this._itemData.overlayType != SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT;
            if(this.overlayType.visible)
            {
               this.overlayType.gotoAndStop(this._itemData.overlayType);
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.checkIcon.visible)
            {
               this.checkIcon.x = width - this.checkIcon.width - CHECK_ICON_OFFSET;
               this.checkIcon.y = rendererBg.height - this.checkIcon.height >> 1;
               this.descriptionTF.width = this.checkIcon.x - this.descriptionTF.x;
            }
            else
            {
               this.descriptionTF.width = width - this.descriptionTF.x - CHECK_ICON_OFFSET;
            }
            this.descriptionTF.y = rendererBg.height - this.descriptionTF.height >> 1;
         }
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._itemData = VPPackItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.valueTF = null;
         this.descriptionTF = null;
         this.checkIcon = null;
         this.icon.dispose();
         this.icon = null;
         this.overlayType = null;
         super.onDispose();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new VehiclePreviewEvent(VehiclePreviewEvent.SHOW_TOOLTIP,this._itemData));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
