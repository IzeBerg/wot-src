package net.wg.gui.battle.comp7
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Comp7HelpCtrl extends MovieClip implements IDisposable
   {
       
      
      public var hitMc:Sprite = null;
      
      public var textField:TextField = null;
      
      public var textFieldHover:TextField = null;
      
      private var _isDisposed:Boolean = false;
      
      public function Comp7HelpCtrl()
      {
         super();
         this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onHitMcRollOverHandler);
         this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onHitMcRollOutHandler);
         this.hitMc.useHandCursor = this.hitMc.buttonMode = true;
         this.textField.visible = true;
         this.textFieldHover.visible = false;
      }
      
      public final function dispose() : void
      {
         this._isDisposed = true;
         this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onHitMcRollOverHandler);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onHitMcRollOutHandler);
         this.hitMc = null;
         this.textField = null;
         this.textFieldHover = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function setLabel(param1:String) : void
      {
         if(param1 != this.textField.text)
         {
            this.textField.htmlText = this.textFieldHover.htmlText = param1;
            App.utils.commons.updateTextFieldSize(this.textField,true,false);
            App.utils.commons.updateTextFieldSize(this.textFieldHover,true,false);
            this.hitMc.width = this.textField.textWidth;
         }
      }
      
      private function onHitMcRollOverHandler(param1:MouseEvent) : void
      {
         this.textField.visible = false;
         this.textFieldHover.visible = true;
      }
      
      private function onHitMcRollOutHandler(param1:MouseEvent) : void
      {
         this.textField.visible = true;
         this.textFieldHover.visible = false;
      }
   }
}
