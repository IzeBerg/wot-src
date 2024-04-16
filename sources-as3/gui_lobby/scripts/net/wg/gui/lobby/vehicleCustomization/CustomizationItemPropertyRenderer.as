package net.wg.gui.lobby.vehicleCustomization
{
   import flash.text.TextField;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.gui.components.controls.IconText;
   
   public class CustomizationItemPropertyRenderer extends IconText
   {
      
      protected static const TEXT_OFFSET:uint = 10;
      
      protected static const INV_ICON_TEXT:String = "InvIconText";
      
      protected static const INV_TEXT_OFFSET:String = "InvTextOffset";
       
      
      public var iconTF:TextField = null;
      
      private var _isTextIcon:Boolean = false;
      
      private var _isWideOffset:Boolean = false;
      
      public function CustomizationItemPropertyRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_ICON))
         {
            this.iconTF.text = icon;
         }
         if(isInvalid(INV_ICON_TEXT))
         {
            this.iconTF.visible = this._isTextIcon;
            iconClip.visible = !this._isTextIcon;
         }
         if(isInvalid(INV_POSITION) && isInvalid(INV_TEXT_OFFSET))
         {
            if(iconClip && this._isWideOffset && iconPosition == IconTextPosition.LEFT)
            {
               textField.x += TEXT_OFFSET;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this.iconTF = null;
      }
      
      public function get numLines() : uint
      {
         return textField.numLines;
      }
      
      public function get isTextIcon() : Boolean
      {
         return this._isTextIcon;
      }
      
      public function set isTextIcon(param1:Boolean) : void
      {
         this._isTextIcon = param1;
         invalidate(INV_ICON_TEXT);
      }
      
      public function get isWideOffset() : Boolean
      {
         return this._isWideOffset;
      }
      
      public function set isWideOffset(param1:Boolean) : void
      {
         this._isWideOffset = param1;
         invalidate(INV_TEXT_OFFSET);
      }
   }
}
