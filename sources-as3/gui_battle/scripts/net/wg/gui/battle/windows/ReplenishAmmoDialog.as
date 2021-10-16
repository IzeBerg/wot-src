package net.wg.gui.battle.windows
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.tutorial.windows.TutorialDialog;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   import scaleform.gfx.TextFieldEx;
   
   public class ReplenishAmmoDialog extends TutorialDialog
   {
      
      private static const MESSAGE_Y_OFFSET:Number = 12;
      
      private static const BUTTON_Y_OFFSET:Number = 15;
      
      private static const BACKGROUND_Y_OFFSET:Number = 20;
       
      
      public var titleField:TextField = null;
      
      public var bg:MovieClip = null;
      
      private var _stageWidth:int = -1;
      
      private var _stageHeight:int = -1;
      
      private var _dialogWidth:int = -1;
      
      private var _dialogHeight:int = -1;
      
      private var _offsetX:int = -1;
      
      private var _offsetY:int = -1;
      
      private var _align:String = "";
      
      private const TOP_LEFT:String = "TL";
      
      private const TOP_RIGHT:String = "TR";
      
      private const TOP_CENTER:String = "TC";
      
      private const CENTER_LEFT:String = "CL";
      
      private const CENTER_RIGHT:String = "CR";
      
      private const CENTER_CENTER:String = "CC";
      
      private const BOTTOM_LEFT:String = "BL";
      
      private const BOTTOM_RIGHT:String = "BR";
      
      private const BOTTOM_CENTER:String = "BC";
      
      public function ReplenishAmmoDialog()
      {
         super();
         showWindowBgForm = false;
         showWindowBg = false;
         this.titleField.wordWrap = true;
         this.titleField.autoSize = TextFieldAutoSize.LEFT;
         messageField.wordWrap = true;
         messageField.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setNoTranslate(this.titleField,true);
         TextFieldEx.setNoTranslate(messageField,true);
      }
      
      override protected function drawData() : void
      {
         this.titleField.text = data.title;
         messageField.y = this.titleField.y + this.titleField.textHeight + MESSAGE_Y_OFFSET ^ 0;
         messageField.text = data.message;
         submitBtn.y = messageField.y + messageField.textHeight + BUTTON_Y_OFFSET ^ 0;
         submitBtn.label = data.submitLabel;
         this.bg.height = submitBtn.y + submitBtn.height + BACKGROUND_Y_OFFSET ^ 0;
         this._offsetX = data.offsetX;
         this._offsetY = data.offsetY;
         this._align = data.align;
         this._dialogWidth = this.bg.width;
         this._dialogHeight = this.bg.height;
         this.updateDialogPosition();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(submitBtn);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._stageWidth = param1;
         this._stageHeight = param2;
         this.updateDialogPosition();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(window)
         {
            window.contentPadding = new Padding(0,0,0,0);
         }
      }
      
      private function updateDialogPosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this._offsetX;
         var _loc4_:int = this._offsetY;
         switch(this._align)
         {
            case this.TOP_LEFT:
               _loc1_ = 0;
               _loc2_ = 0;
               break;
            case this.TOP_RIGHT:
               _loc1_ = this._stageWidth - this._dialogWidth;
               _loc2_ = 0;
               _loc3_ = -this._offsetX;
               break;
            case this.TOP_CENTER:
               _loc1_ = this._stageWidth - this._dialogWidth >> 1;
               _loc2_ = 0;
               break;
            case this.CENTER_LEFT:
               _loc1_ = 0;
               _loc2_ = this._stageHeight - this._dialogHeight >> 1;
               break;
            case this.CENTER_RIGHT:
               _loc1_ = this._stageWidth - this._dialogWidth;
               _loc2_ = this._stageHeight - this._dialogHeight >> 1;
               _loc3_ = -this._offsetX;
               break;
            case this.CENTER_CENTER:
               _loc1_ = this._stageWidth - this._dialogWidth >> 1;
               _loc2_ = this._stageHeight - this._dialogHeight >> 1;
               break;
            case this.BOTTOM_LEFT:
               _loc1_ = 0;
               _loc2_ = this._stageHeight - this._dialogHeight;
               _loc4_ = -this._offsetY;
               break;
            case this.BOTTOM_RIGHT:
               _loc1_ = this._stageWidth - this._dialogWidth;
               _loc2_ = this._stageHeight - this._dialogHeight;
               _loc3_ = -this._offsetX;
               _loc4_ = -this._offsetY;
               break;
            case this.BOTTOM_CENTER:
               _loc1_ = this._stageWidth - this._dialogWidth >> 1;
               _loc2_ = this._stageHeight - this._dialogHeight;
               _loc4_ = -this._offsetY;
         }
         window.x = _loc1_ + _loc3_ ^ 0;
         window.y = _loc2_ + _loc4_ ^ 0;
      }
      
      override protected function onDispose() : void
      {
         this.titleField = null;
         this.bg = null;
         super.onDispose();
      }
   }
}
