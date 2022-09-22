package net.wg.gui.battle.eventBattle.views.timersPanel
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   import net.wg.utils.IClassFactory;
   
   public class WtTimer extends DestroyTimer
   {
       
      
      private var _iconContent:DisplayObject = null;
      
      public function WtTimer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._iconContent = null;
         super.onDispose();
      }
      
      override public function updateData(param1:StatusNotificationVO) : void
      {
         super.updateData(param1);
         if(this._iconContent is ITimerIconContent)
         {
            ITimerIconContent(this._iconContent).updateData(param1);
         }
      }
      
      override public function setSettings(param1:NotificationTimerSettingVO) : void
      {
         super.setSettings(param1);
         if(this._iconContent is ITimerIconContent)
         {
            ITimerIconContent(this._iconContent).setSettings(param1);
         }
      }
      
      override protected function setIcon(param1:NotificationTimerSettingVO) : void
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:Class = _loc2_.getClass(param1.iconName);
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is BitmapData)
         {
            setBitmapIcon(_loc4_ as BitmapData,param1.iconOffsetY);
         }
         else if(_loc4_ is DisplayObject)
         {
            this._iconContent = _loc4_ as DisplayObject;
            iconContainer.addChild(this._iconContent);
            this._iconContent.y = param1.iconOffsetY;
         }
         invalidate(ICON_BTM_POSITION_VALIDATE);
      }
      
      override public function setStaticText(param1:String, param2:String = "") : void
      {
      }
   }
}
