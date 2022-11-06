package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import net.wg.data.constants.IconTextPosition;
   import scaleform.clik.constants.InvalidationType;
   
   public class InfoButtonText extends SoundButtonEx
   {
      
      private static const ICON_WIDTH:uint = 14;
      
      private static const ICON_TEXT_GAP:int = 3;
      
      private static const HIT_MC_WIDTH_OFFSET:int = 10;
       
      
      public var icon:DisplayObject = null;
      
      public var textContainer:DisplayObjectContainer = null;
      
      private var _iconPosition:String = "left";
      
      private var _actualIconPosition:String = "left";
      
      public function InfoButtonText()
      {
         super();
         textField1 = TextField(this.textContainer.getChildByName("textField1"));
         preventAutosizing = true;
         constraintsDisabled = true;
         textField1.x += ICON_WIDTH + ICON_TEXT_GAP;
      }
      
      override protected function onDispose() : void
      {
         this.textContainer = null;
         this.icon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT) && this._actualIconPosition != this._iconPosition)
         {
            if(this._iconPosition == IconTextPosition.LEFT)
            {
               this.icon.x = hitMc.x = textField1.x;
               textField1.x += ICON_WIDTH + ICON_TEXT_GAP;
            }
            else
            {
               textField1.x = this.icon.x;
               hitMc.x = textField1.x - HIT_MC_WIDTH_OFFSET;
               this.icon.x += textField1.width + ICON_TEXT_GAP;
            }
            this._actualIconPosition = this._iconPosition;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            hitMc.width = textField1.width + ICON_TEXT_GAP + ICON_WIDTH + HIT_MC_WIDTH_OFFSET;
            if(this._actualIconPosition == IconTextPosition.RIGHT)
            {
               this.icon.x = textField1.x + textField1.width + ICON_TEXT_GAP;
            }
            setSize(hitMc.width,_height);
         }
      }
      
      public function get iconPosition() : String
      {
         return this._actualIconPosition;
      }
      
      public function set iconPosition(param1:String) : void
      {
         if(param1 != IconTextPosition.LEFT && param1 != IconTextPosition.RIGHT || param1 == this._iconPosition)
         {
            return;
         }
         this._iconPosition = param1;
         invalidateLayout();
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         App.utils.commons.updateTextFieldSize(textField1,true,false);
      }
   }
}
