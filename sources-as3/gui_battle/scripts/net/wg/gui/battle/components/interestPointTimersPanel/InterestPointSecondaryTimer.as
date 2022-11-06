package net.wg.gui.battle.components.interestPointTimersPanel
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimerBase;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.utils.IClassFactory;
   
   public class InterestPointSecondaryTimer extends SecondaryTimerBase implements IStatusNotification
   {
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
       
      
      public var icon:Sprite = null;
      
      public var descr:TextFieldContainer = null;
      
      private var _iconBitmap:Bitmap = null;
      
      private var _isShowing:Boolean = false;
      
      public function InterestPointSecondaryTimer()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      override public function hideTimer() : void
      {
         gotoAndPlay(HIDE_FRAME_LABEL);
         this._isShowing = false;
      }
      
      override public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:Class = _loc2_.getClass(param1.iconName);
         this._iconBitmap = new Bitmap(new _loc3_());
         this._iconBitmap.x = -this._iconBitmap.width >> 1;
         this._iconBitmap.y = -this._iconBitmap.height >> 1;
         this.icon.addChild(this._iconBitmap);
         super.setSettings(param1);
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
         this.descr.label = param2;
      }
      
      override public function showTimer(param1:Boolean) : void
      {
         gotoAndPlay(SHOW_FRAME_LABEL);
         this._isShowing = true;
      }
      
      override protected function onDispose() : void
      {
         if(this._iconBitmap)
         {
            this.icon.removeChild(this._iconBitmap);
         }
         this.icon = null;
         this.descr.dispose();
         this.descr = null;
         this._iconBitmap = null;
         super.onDispose();
      }
      
      override protected function getTimerTF() : TextField
      {
         return null;
      }
      
      override protected function setTimerTimeString() : void
      {
      }
      
      override protected function resetAnimState() : void
      {
      }
      
      public function getStatusCallback() : IStatusNotificationCallback
      {
         return undefined;
      }
      
      public function updateViewID(param1:String, param2:Boolean, param3:int = -1) : void
      {
      }
      
      public function get isShowing() : Boolean
      {
         return this._isShowing;
      }
      
      public function get actualWidth() : Number
      {
         return 0;
      }
      
      public function updateData(param1:StatusNotificationVO) : void
      {
         this.setStaticText(param1.title,param1.description);
         this.updateViewID(param1.viewSubType,false);
         updateRadialTimer(param1.totalTime,param1.currentTime);
      }
   }
}
