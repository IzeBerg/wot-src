package net.wg.gui.battle.eventBattle.views.battleTimer
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class EventTextFieldContainer extends TextFieldContainer
   {
      
      private static const FRAME_HUNTER:String = "hunter";
      
      private static const FRAME_BOSS:String = "boss";
      
      private static const FRAME_SMALL:String = "_small";
      
      private static const FRAME_BIG:String = "_big";
       
      
      public var icon:MovieClip = null;
      
      private var _isBoss:Boolean = false;
      
      private var _isSmall:Boolean = true;
      
      private var _isOvertime:Boolean = false;
      
      private var _currentFrame:String = "";
      
      public function EventTextFieldContainer()
      {
         super();
         this.icon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this.icon = null;
      }
      
      override protected function updateSize() : void
      {
         this._currentFrame = "";
         this._currentFrame += this._isBoss == this._isOvertime ? FRAME_BOSS : FRAME_HUNTER;
         this._currentFrame += !!this._isSmall ? FRAME_SMALL : FRAME_BIG;
         this.icon.gotoAndStop(this._currentFrame);
         super.updateSize();
         textField.x = -textField.width | 0;
         textField.y = -textField.height >> 1;
         this.icon.x = textField.x - (this.icon.width >> 1);
      }
      
      public function set isBoss(param1:Boolean) : void
      {
         if(this._isBoss != param1)
         {
            this._isBoss = param1;
            this.updateSize();
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            this.updateSize();
         }
      }
      
      public function set isOvertime(param1:Boolean) : void
      {
         if(this._isOvertime != param1)
         {
            this._isOvertime = param1;
            this.icon.visible = this._isOvertime;
         }
      }
   }
}
