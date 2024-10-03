package net.wg.white_tiger.gui.battle.views.wtBattleTimer
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class WTTextFieldContainer extends TextFieldContainer
   {
      
      private static const FRAME_HUNTER:String = "hunter";
      
      private static const FRAME_BOSS:String = "boss";
      
      private static const FRAME_SMALL:String = "_small";
      
      private static const FRAME_BIG:String = "_big";
       
      
      public var icon:MovieClip = null;
      
      private var _isBoss:Boolean = false;
      
      private var _isSmall:Boolean = true;
      
      private var _isOvertime:Boolean = false;
      
      public function WTTextFieldContainer()
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
         var _loc1_:String = "";
         _loc1_ += this._isBoss == this._isOvertime ? FRAME_BOSS : FRAME_HUNTER;
         _loc1_ += !!this._isSmall ? FRAME_SMALL : FRAME_BIG;
         this.icon.gotoAndStop(_loc1_);
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
