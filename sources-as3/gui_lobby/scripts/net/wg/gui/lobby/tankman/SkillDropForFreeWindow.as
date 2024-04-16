package net.wg.gui.lobby.tankman
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.meta.impl.SkillDropForFreeMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SkillDropForFreeWindow extends SkillDropForFreeMeta
   {
      
      private static const DELAY:int = 200;
      
      private static const GOLD:String = "gold";
       
      
      public var beforeBlock:TankmanSkillsInfoBlock;
      
      public var buttonCancel:SoundButtonEx;
      
      public var buttonDrop:SoundButtonEx;
      
      public var goldButton:TankmanTrainingSmallButton;
      
      public var actionTimeDescrTF:TextField;
      
      public var clock:Sprite;
      
      public var timeLeftTF:TextField;
      
      public var timerHitZone:Sprite;
      
      public var model:SkillDropForFreeModel;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _locale:ILocale;
      
      private var _intervalID:uint = 0;
      
      private var _endTime:Number;
      
      public function SkillDropForFreeWindow()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._locale = App.utils.locale;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.actionTimeDescrTF.autoSize = TextFieldAutoSize.LEFT;
         this.clock.x = Math.round(this.actionTimeDescrTF.width + 5);
         this.timerHitZone.x = this.clock.x + 4;
         this.timeLeftTF.autoSize = TextFieldAutoSize.LEFT;
         this.timeLeftTF.x = this.clock.x + this.clock.width - 9;
         this.goldButton.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
         this.goldButton.doubleClickEnabled = true;
         this.buttonDrop.addEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.addEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.clearTimer();
         App.utils.scheduler.cancelTask(this.updateWindowSize);
         this.buttonDrop.removeEventListener(ButtonEvent.CLICK,this.onButtonDropClickHandler);
         this.buttonCancel.removeEventListener(ButtonEvent.CLICK,this.onButtonCancelClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.beforeBlock.dispose();
         this.beforeBlock = null;
         this.buttonCancel.dispose();
         this.buttonCancel = null;
         this.buttonDrop.dispose();
         this.buttonDrop = null;
         this.goldButton.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDropButtonDoubleClickHandler);
         this.goldButton.dispose();
         this.goldButton = null;
         this._tooltipMgr = null;
         this.model = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.model)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.validateData();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.validateLayout();
            }
         }
      }
      
      override protected function setData(param1:SkillDropForFreeModel) : void
      {
         this.model = param1;
         this._endTime = getTimer() + param1.timeLeft * Time.MILLISECOND_IN_SECOND;
         var _loc2_:Object = {
            "enabled":true,
            "isMoneyEnough":true,
            "isNativeVehicle":true,
            "showAction":true,
            "level":"100%",
            "nation":this.model.nation,
            "price":[GOLD,0]
         };
         this.goldButton.setData(new RetrainButtonVO(_loc2_));
         invalidate(InvalidationType.DATA,InvalidationType.LAYOUT);
      }
      
      protected function validateLayout() : void
      {
         App.utils.scheduler.scheduleOnNextFrame(this.updateWindowSize);
      }
      
      protected function validateData() : void
      {
         this.beforeBlock.nation = this.model.nation;
         this.beforeBlock.tankmanName = this.model.tankmanName;
         this.beforeBlock.portraitSource = this.model.tankmanIcon;
         this.beforeBlock.roleSource = this.model.roleIcon;
         this.beforeBlock.setRoleLevel(this.model.roleLevel);
         this.clearTimer();
         this.updateTimer();
         this._intervalID = setInterval(this.updateTimer,DELAY);
         this.autoSelectSavingMode();
         this.recalculateData();
      }
      
      private function updateTimer() : void
      {
         var _loc1_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = Math.round((this._endTime - getTimer()) / Time.MILLISECOND_IN_SECOND);
         if(_loc2_ > 0)
         {
            _loc3_ = _loc2_ / (Time.SECONDS_IN_MINUTE * Time.MINUTES_IN_HOUR * Time.HOURS_IN_DAY);
            if(_loc3_ > 0)
            {
               _loc1_ = this._locale.makeString(MENU.SKILLDROPFORFREEWINDOW_DAYS,{"value":String(_loc3_)});
            }
            else
            {
               _loc4_ = _loc2_ / (Time.SECONDS_IN_MINUTE * Time.MINUTES_IN_HOUR);
               if(_loc4_ > 0)
               {
                  _loc1_ = this._locale.makeString(MENU.SKILLDROPFORFREEWINDOW_HOURS,{"value":String(_loc4_)});
               }
               else
               {
                  _loc5_ = _loc2_ / Time.SECONDS_IN_MINUTE;
                  if(_loc5_ > 0)
                  {
                     _loc1_ = this._locale.makeString(MENU.SKILLDROPFORFREEWINDOW_MINUTES,{"value":String(_loc5_)});
                  }
                  else
                  {
                     _loc1_ = this._locale.makeString(MENU.SKILLDROPFORFREEWINDOW_SECONDS,{"value":String(_loc2_)});
                  }
               }
            }
         }
         else
         {
            _loc1_ = this._locale.makeString(MENU.SKILLDROPFORFREEWINDOW_SECONDS,{"value":"0"});
            this.clearTimer();
         }
         this.timeLeftTF.text = _loc1_;
         this.timerHitZone.width = this.timeLeftTF.x + this.timeLeftTF.width + 3 - this.clock.x;
      }
      
      private function clearTimer() : void
      {
         if(this._intervalID != 0)
         {
            clearInterval(this._intervalID);
            this._intervalID = 0;
         }
      }
      
      private function updateWindowSize() : void
      {
         height = this.actualHeight;
         window.invalidate(Window.INVALID_SRC_VIEW);
      }
      
      private function autoSelectSavingMode() : void
      {
         this.goldButton.selected = true;
      }
      
      private function recalculateData() : void
      {
         this.beforeBlock.setSkills(this.model.skillsCount,this.model.preLastSkill,this.model.lastSkill,this.model.lastSkillLevel,this.model.hasNewSkill,this.model.newSkillsCount,this.model.lastNewSkillLevel);
      }
      
      private function onDropButtonDoubleClickHandler(param1:MouseEvent) : void
      {
         this.onButtonDropClickHandler(null);
      }
      
      private function onButtonCancelClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onButtonDropClickHandler(param1:ButtonEvent) : void
      {
         dropSkillsS();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.enabled)
         {
            return;
         }
         if(param1.target == this.timerHitZone)
         {
            this._tooltipMgr.show(MENU.SKILLDROPFORFREEWINDOW_TIMER_TOOLTIP);
         }
         else if(param1.target == this.goldButton)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.PRICE_DISCOUNT,null,0,this.model.dropSkillGold.gold,GOLD);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
