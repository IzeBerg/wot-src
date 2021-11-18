package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverEditedItemRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationPopoverEditedItemRenderer extends CustomizationPopoverItemRenderer
   {
      
      private static const ICON_OFFSET:int = 80;
      
      private static const NAME_X_NORMAL:int = 122;
      
      private static const HEIGHT:Number = 48;
       
      
      public var titleTF:TextField = null;
      
      public var removedTF:TextField = null;
      
      public var editedIcon:Image = null;
      
      public var titleBg:Sprite = null;
      
      private var _model:CustomizationPopoverEditedItemRendererVO = null;
      
      public function CustomizationPopoverEditedItemRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.editedIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_EDITED_SMALL;
         this.removedTF.autoSize = TextFieldAutoSize.RIGHT;
         this.titleTF.mouseEnabled = this.removedTF.mouseEnabled = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         isPassive = mouseEnabledOnDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this.removedTF = null;
         this.titleTF = null;
         this.titleBg = null;
         this.editedIcon.dispose();
         this.editedIcon = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.removedTF.htmlText = this._model.disabledLabel;
            this.titleTF.htmlText = this._model.titleLabel;
            this.titleBg.visible = this._model.isTitle;
            if(this._model.isTitle)
            {
               this.editedIcon.visible = false;
            }
            else
            {
               enabled = !this._model.isDisabled;
               updateDisable(this._model.isDisabled);
               this.removedTF.visible = this._model.isDisabled;
               inStorageIcon.visible = inStorageIcon.visible && !this._model.isDisabled;
               this.editedIcon.visible = this._model.isEdited;
               removeBtn.visible = enabled && this._model.isRemovable;
            }
         }
      }
      
      override protected function layoutItemIcon() : void
      {
         itemIcon.x = ICON_OFFSET - (itemIcon.width >> 1) ^ 0;
      }
      
      override protected function layoutName(param1:Boolean) : void
      {
         nameTF.visible = !param1;
         nameTF.x = NAME_X_NORMAL;
      }
      
      override protected function updateVisibility(param1:Boolean) : void
      {
         super.updateVisibility(param1);
         this.removedTF.visible = param1;
         this.editedIcon.visible = param1;
         this.titleTF.visible = param1;
         this.titleBg.visible = param1;
      }
      
      override protected function removeItem() : void
      {
         dispatchEvent(new CustomizationIndicatorEvent(CustomizationIndicatorEvent.REMOVAL,this._model.id,this._model.itemsList,this._model.seasonType));
      }
      
      override public function setData(param1:Object) : void
      {
         this._model = Boolean(param1) ? CustomizationPopoverEditedItemRendererVO(param1) : null;
         super.setData(param1);
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
