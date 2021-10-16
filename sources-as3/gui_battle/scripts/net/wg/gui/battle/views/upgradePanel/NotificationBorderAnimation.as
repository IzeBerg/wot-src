package net.wg.gui.battle.views.upgradePanel
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NotificationBorderAnimation extends MovieClip implements IDisposable
   {
      
      private static const FIRST_FRAME:uint = 1;
      
      private static const FADE_IN_FRAME:uint = 2;
       
      
      public var notificationBorder01:NotificationBorderContainer = null;
      
      public var notificationBorder02:NotificationBorderContainer = null;
      
      public var notificationBorder03:NotificationBorderContainer = null;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function NotificationBorderAnimation()
      {
         super();
         this.reset();
         this._width = super.width;
         this._height = super.height;
      }
      
      public final function dispose() : void
      {
         this.notificationBorder01.dispose();
         this.notificationBorder01 = null;
         this.notificationBorder02.dispose();
         this.notificationBorder02 = null;
         this.notificationBorder03.dispose();
         this.notificationBorder03 = null;
      }
      
      public function fadeIn() : void
      {
         gotoAndPlay(FADE_IN_FRAME);
      }
      
      public function reset() : void
      {
         gotoAndStop(FIRST_FRAME);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this.notificationBorder01.width = param1;
         this.notificationBorder02.width = param1;
         this.notificationBorder03.width = param1;
         this._width = param1;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         this.notificationBorder01.height = param1;
         this.notificationBorder02.height = param1;
         this.notificationBorder03.height = param1;
         this._height = param1;
      }
   }
}
