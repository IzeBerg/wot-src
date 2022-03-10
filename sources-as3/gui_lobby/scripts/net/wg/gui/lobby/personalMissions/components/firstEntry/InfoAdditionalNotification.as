package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoAdditionalNotification extends Sprite implements IDisposable
   {
      
      private static const ICON_GAP:int = 0;
      
      private static const ICON_VERTICAL_SHIFT:int = 4;
      
      private static const LABELTF_START_WIDTH:int = 960;
       
      
      public var labelTF:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var lineUp:Sprite = null;
      
      public var lineDown:Sprite = null;
      
      private var _notificationInnerTopGap:int = 0;
      
      private var _notificationInnerBottomGap:int = 0;
      
      private var _notificationWidth:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function InfoAdditionalNotification()
      {
         super();
         this.icon.visible = false;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.lineUp = null;
         this.lineDown = null;
         this.labelTF = null;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.labelTF.width = LABELTF_START_WIDTH;
         this.labelTF.text = param1;
         App.utils.commons.updateTextFieldSize(this.labelTF,true,true);
         this.icon.source = param2;
         this.updatePositions();
      }
      
      public function setSettings(param1:int, param2:int, param3:int) : void
      {
         this._notificationInnerTopGap = param1;
         this._notificationInnerBottomGap = param2;
         this._notificationWidth = param3;
         this.updatePositions();
      }
      
      private function updatePositions() : void
      {
         var _loc1_:int = this.icon.width + ICON_GAP + this.labelTF.width;
         this.icon.x = -_loc1_ >> 1;
         this.labelTF.x = this.icon.x + this.icon.width + ICON_GAP;
         this.labelTF.y = this._notificationInnerTopGap;
         this.icon.y = this.labelTF.y + ICON_VERTICAL_SHIFT;
         this.lineUp.width = this.lineDown.width = this._notificationWidth;
         this.lineUp.x = this.lineDown.x = -this._notificationWidth >> 1;
         this.lineDown.y = this.labelTF.y + this.labelTF.height + this._notificationInnerBottomGap;
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updatePositions();
         this.icon.visible = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
