package net.wg.gui.battle.views.destroyTimers
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.SimpleNotifier;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.TextNotifier;
   import net.wg.gui.battle.views.destroyTimers.utils.pairs.NotifierPair;
   import net.wg.gui.battle.views.destroyTimers.utils.pairs.NotifierPairState;
   import net.wg.gui.battle.views.destroyTimers.utils.pairs.ProgressNotifierPair;
   import net.wg.gui.battle.views.destroyTimers.utils.pairs.TimerNotifierPair;
   import net.wg.infrastructure.base.meta.IEventDestroyTimersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventDestroyTimersPanelMeta;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventDestroyTimersPanel extends EventDestroyTimersPanelMeta implements IEventDestroyTimersPanelMeta
   {
      
      protected static const INVALID_WARNING:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const SECONDARY_X_POSITION:int = 110;
      
      private static const RIBBONS_PANEL_NO_OVERLAY_MIN:int = 1160;
      
      private static const BUFFS_PANEL_NO_OVERLAY_MIN:int = 960;
       
      
      public var warningTF:TextField = null;
      
      private var _warningText:String = "";
      
      private var _waitForAlliesNotifier:NotifierPair;
      
      private var _timerNotifier:TimerNotifierPair;
      
      private var _fillingProgress:ProgressNotifierPair;
      
      private var _currentPair:NotifierPair;
      
      public function EventDestroyTimersPanel()
      {
         super();
         var _loc1_:IClassFactory = App.utils.classFactory;
         var _loc2_:TextNotifier = _loc1_.getComponent(Linkages.EVENT_WAIT_FOR_ALLIES_UI,TextNotifier);
         _loc2_.setText(App.utils.locale.makeString(EVENT.NOTIFICATION_WAITFORALLIES));
         var _loc3_:SimpleNotifier = _loc1_.getComponent(Linkages.SECONDARY_EVENT_WAIT_FOR_ALLIES_UI,SimpleNotifier);
         this._waitForAlliesNotifier = new NotifierPair(_loc2_,_loc3_);
         this._fillingProgress = new ProgressNotifierPair(App.utils.locale.makeString(EVENT.NOTIFICATION_FILLINGIN));
         this._timerNotifier = new TimerNotifierPair();
      }
      
      override public function as_setSpeed(param1:Number) : void
      {
         this._timerNotifier.setSpeed(param1);
         super.as_setSpeed(param1);
      }
      
      private function setOverlay() : void
      {
         setComponentsOverlayS(stageHeight < RIBBONS_PANEL_NO_OVERLAY_MIN,stageHeight < BUFFS_PANEL_NO_OVERLAY_MIN);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_STATE))
         {
            if(this._currentPair != null)
            {
               if(!isAnyTimerActive())
               {
                  this._currentPair.state = NotifierPairState.NORMAL;
               }
               else if(!isAnySecondaryTimerActive())
               {
                  this._currentPair.state = NotifierPairState.COLLAPSED;
               }
               else
               {
                  this._currentPair.state = NotifierPairState.HIDDEN;
               }
            }
            this.setOverlay();
         }
         if(isInvalid(INVALID_WARNING))
         {
            if(this.warningTF)
            {
               this.warningTF.visible = StringUtils.isNotEmpty(this._warningText);
               this.warningTF.htmlText = this._warningText;
               this.setOverlay();
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.warningTF)
         {
            this.warningTF.visible = false;
         }
         statusContainer.addChild(this._waitForAlliesNotifier.normal);
         statusContainer.addChild(this._fillingProgress.normal);
         statusContainer.addChild(this._timerNotifier.normal);
         secondaryContainer.addChild(this._waitForAlliesNotifier.collapsed);
         this._waitForAlliesNotifier.collapsed.x = SECONDARY_X_POSITION;
         secondaryContainer.addChild(this._fillingProgress.collapsed);
         this._fillingProgress.collapsed.x = SECONDARY_X_POSITION;
         secondaryContainer.addChild(this._timerNotifier.collapsed);
         this._timerNotifier.collapsed.x = SECONDARY_X_POSITION;
      }
      
      override protected function onDispose() : void
      {
         this.warningTF = null;
         statusContainer.removeChild(this._waitForAlliesNotifier.normal);
         secondaryContainer.removeChild(this._waitForAlliesNotifier.collapsed);
         this._waitForAlliesNotifier.dispose();
         this._waitForAlliesNotifier = null;
         statusContainer.removeChild(this._fillingProgress.normal);
         secondaryContainer.removeChild(this._fillingProgress.collapsed);
         this._fillingProgress.dispose();
         this._fillingProgress = null;
         statusContainer.removeChild(this._timerNotifier.normal);
         secondaryContainer.removeChild(this._timerNotifier.collapsed);
         this._timerNotifier.dispose();
         this._timerNotifier = null;
         this._currentPair = null;
         super.onDispose();
      }
      
      public function as_hideAllNotifications() : void
      {
         if(this._currentPair != null)
         {
            this.hideNotifierPair(this._currentPair);
         }
      }
      
      public function as_setFillingInProgress(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(param4)
         {
            this.setCurrentNotifierPair(this._fillingProgress);
            this._fillingProgress.setProgress(param1,param2,param3);
         }
         else
         {
            this.hideNotifierPair(this._fillingProgress);
         }
      }
      
      public function as_setGotoPointTimer(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         if(param4)
         {
            this.setCurrentNotifierPair(this._timerNotifier);
            this._timerNotifier.setData(param1,param2);
            this._timerNotifier.setMessage(param3);
         }
         else
         {
            this.hideNotifierPair(this._timerNotifier);
         }
      }
      
      public function as_setWaitForAllies(param1:Boolean) : void
      {
         if(param1)
         {
            this.setCurrentNotifierPair(this._waitForAlliesNotifier);
         }
         else
         {
            this.hideNotifierPair(this._waitForAlliesNotifier);
         }
      }
      
      public function as_setWarningText(param1:String) : void
      {
         this._warningText = param1;
         invalidate(INVALID_WARNING);
      }
      
      private function hideNotifierPair(param1:NotifierPair) : void
      {
         if(this._currentPair == param1)
         {
            this.setCurrentNotifierPair(null);
         }
      }
      
      private function setCurrentNotifierPair(param1:NotifierPair) : void
      {
         if(this._currentPair == param1)
         {
            return;
         }
         if(this._currentPair != null)
         {
            this._currentPair.state = NotifierPairState.INACTIVE;
            this._currentPair = null;
         }
         this._currentPair = param1;
         invalidate(INVALID_STATE);
      }
   }
}
