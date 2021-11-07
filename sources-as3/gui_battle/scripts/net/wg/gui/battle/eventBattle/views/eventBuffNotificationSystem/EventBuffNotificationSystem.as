package net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem.data.BuffNotificationInfoVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IEventBuffNotificationSystemMeta;
   import net.wg.infrastructure.base.meta.impl.EventBuffNotificationSystemMeta;
   import net.wg.utils.ICommons;
   import scaleform.clik.motion.Tween;
   
   public class EventBuffNotificationSystem extends EventBuffNotificationSystemMeta implements IEventBuffNotificationSystemMeta
   {
      
      private static const SHOW_BUFF_NOTIFICATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const BACK_WIDTH_MIN:int = 250;
      
      private static const BACK_WIDTH_MAX:int = 400;
      
      private static const BACK_WIDTH_OFFSET:int = 20;
      
      private static const DOTS:String = "...";
      
      private static const FADE_IN_DURATION:int = 2000;
      
      private static const FADE_OUT_DURATION:int = 500;
       
      
      public var icon:UILoaderAlt = null;
      
      public var titleTF:TextField = null;
      
      public var timeDescription1TF:TextField = null;
      
      public var description1TF:TextField = null;
      
      public var timeDescription2TF:TextField = null;
      
      public var description2TF:TextField = null;
      
      public var infoTF:TextField = null;
      
      public var back:Sprite = null;
      
      private var _data:BuffNotificationInfoVO = null;
      
      private var _tween:Tween = null;
      
      private var _commons:ICommons = null;
      
      public function EventBuffNotificationSystem()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.setText(this.infoTF,App.utils.locale.makeString(EVENT.NOTIFICATION_MOREINFORMATION));
         alpha = 0;
      }
      
      private function setText(param1:TextField, param2:String) : void
      {
         param1.text = param2;
         var _loc3_:int = param1.x + param1.textWidth + BACK_WIDTH_OFFSET;
         if(_loc3_ > BACK_WIDTH_MAX)
         {
            param1.width = BACK_WIDTH_MAX - param1.x - BACK_WIDTH_OFFSET;
            param1.text = this._commons.truncateTextFieldText(param1,param2,true,true,DOTS);
         }
         else
         {
            this._commons.updateTextFieldSize(param1,true,false);
         }
      }
      
      private function setBackWidth() : void
      {
         var _loc1_:int = Math.max(this.titleTF.x + this.titleTF.textWidth,this.description1TF.x + this.description1TF.textWidth,this.description2TF.x + this.description2TF.textWidth,this.infoTF.x + this.infoTF.textWidth);
         this.back.width = Math.max(_loc1_ + BACK_WIDTH_OFFSET,BACK_WIDTH_MIN);
         dispatchEvent(new ResizableBuffNotificationSystemEvent(ResizableBuffNotificationSystemEvent.CHANGED_WIDTH_EVENT,true));
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(SHOW_BUFF_NOTIFICATION))
         {
            this.icon.source = this._data.iconSource;
            this.setText(this.titleTF,this._data.title);
            this.timeDescription1TF.text = this._data.timeDescription1;
            this.setText(this.description1TF,this._data.description1);
            this.timeDescription2TF.text = this._data.timeDescription2;
            this.setText(this.description2TF,this._data.description2);
            this.setBackWidth();
            this.removeTween();
            this._tween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{"fastTransform":false});
         }
      }
      
      private function removeTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.titleTF = null;
         this.timeDescription1TF = null;
         this.description1TF = null;
         this.timeDescription2TF = null;
         this.description2TF = null;
         this.infoTF = null;
         this.back = null;
         this._data = null;
         this._commons = null;
         this.removeTween();
         super.onDispose();
      }
      
      override protected function showBuffNotification(param1:BuffNotificationInfoVO) : void
      {
         this._data = param1;
         invalidate(SHOW_BUFF_NOTIFICATION);
      }
      
      public function as_hideBuffNotification() : void
      {
         this.removeTween();
         this._tween = new Tween(FADE_OUT_DURATION,this,{"alpha":0},{"fastTransform":false});
      }
      
      public function isShown() : Boolean
      {
         return alpha > 0;
      }
   }
}
