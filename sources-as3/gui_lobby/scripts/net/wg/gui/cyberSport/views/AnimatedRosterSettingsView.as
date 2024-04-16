package net.wg.gui.cyberSport.views
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class AnimatedRosterSettingsView extends UIComponentEx
   {
       
      
      public var leftBtn:CSVehicleButton;
      
      public var rightBtn:CSVehicleButton;
      
      public var anmSeparator:MovieClip;
      
      private var _animationDuration:Number = 0;
      
      private var tweens:Vector.<Tween>;
      
      private var leftHash;
      
      private var rightHash;
      
      public function AnimatedRosterSettingsView()
      {
         this.tweens = new Vector.<Tween>();
         super();
      }
      
      [Inspectable(defaultValue="1000",type="Number")]
      public function set animationDuration(param1:Number) : void
      {
         this._animationDuration = param1;
      }
      
      public function get animationDuration() : Number
      {
         return this._animationDuration;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.leftBtn.addEventListener(ButtonEvent.CLICK,this.leftBtn_buttonClickHandler);
         this.rightBtn.addEventListener(ButtonEvent.CLICK,this.rightBtn_buttonClickHandler);
      }
      
      public function getModels() : Array
      {
         return [this.leftBtn.getModel(),this.rightBtn.getModel()];
      }
      
      override protected function onDispose() : void
      {
         this.leftBtn.addEventListener(ButtonEvent.CLICK,this.leftBtn_buttonClickHandler);
         this.rightBtn.addEventListener(ButtonEvent.CLICK,this.rightBtn_buttonClickHandler);
         this.leftBtn.dispose();
         this.rightBtn.dispose();
         this.stopPreviousAnimation();
         this.tweens.splice(0,this.tweens.length);
         super.onDispose();
      }
      
      private function leftBtn_buttonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.CLICK_SLOT_SETTINGS_BTN,[0,this.leftBtn.getModel()]));
      }
      
      private function rightBtn_buttonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.CLICK_SLOT_SETTINGS_BTN,[1,this.rightBtn.getModel()]));
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.leftBtn.x = Math.round(this.leftBtn.x);
         this.leftBtn.y = Math.round(this.leftBtn.y);
         if(isInvalid(InvalidationType.DATA))
         {
            this.afterSetData();
         }
      }
      
      private function afterSetData() : void
      {
         this.defType(this.leftBtn,this.leftHash);
         this.defType(this.rightBtn,this.rightHash);
      }
      
      private function defType(param1:CSVehicleButton, param2:*) : void
      {
         if(param2 is Object && param2.hasOwnProperty("isReadyToFight"))
         {
            this.setVehicle(param1,new VehicleVO(param2));
         }
         else if(param2)
         {
            if(param2 is SettingRosterVO)
            {
               this.setRangeData(param1,param2);
            }
            else
            {
               this.setRangeData(param1,new SettingRosterVO(param2));
            }
         }
         else
         {
            this.setDefaultState(param1);
         }
      }
      
      private function setVehicle(param1:CSVehicleButton, param2:VehicleVO) : void
      {
         param1.setVehicle(param2);
      }
      
      private function setRangeData(param1:CSVehicleButton, param2:*) : void
      {
         param1.setRangeData(param2);
      }
      
      private function setDefaultState(param1:CSVehicleButton) : void
      {
         param1.reset();
         param1.selectState(true,CYBERSPORT.BUTTON_MEDALLION_ADDSLOTSETTINGS);
      }
      
      public function setSelectedSettings(param1:int, param2:*) : void
      {
         if(param1 == 0)
         {
            this.defType(this.leftBtn,param2);
         }
         else
         {
            this.defType(this.rightBtn,param2);
         }
      }
      
      public function setData(param1:*, param2:*) : void
      {
         this.leftHash = param1;
         this.rightHash = param2;
         invalidateData();
      }
      
      public function animationIn() : void
      {
         this.setAnimationRules({"x":0});
      }
      
      public function animationOut() : void
      {
         this.setAnimationRules({"x":this.rightBtn.x});
      }
      
      private function setAnimationRules(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.stopPreviousAnimation();
         this.tweens = Vector.<Tween>([new Tween(this.animationDuration,this.leftBtn,param1,{
            "paused":false,
            "ease":Strong.easeOut,
            "onComplete":this.callBack
         })]);
      }
      
      private function callBack(param1:Object) : void
      {
         this.leftBtn.x = Math.round(this.leftBtn.x);
         this.leftBtn.y = Math.round(this.leftBtn.y);
         this.leftBtn.validateNow();
      }
      
      private function stopPreviousAnimation() : void
      {
         var _loc1_:Tween = null;
         if(this.tweens)
         {
            for each(_loc1_ in this.tweens)
            {
               _loc1_.paused = true;
               _loc1_ = null;
            }
         }
      }
   }
}
