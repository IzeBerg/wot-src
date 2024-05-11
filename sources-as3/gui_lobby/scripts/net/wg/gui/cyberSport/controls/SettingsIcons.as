package net.wg.gui.cyberSport.controls
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SettingsIcons extends UIComponentEx
   {
       
      
      public var flake:UILoaderAlt;
      
      public var gear:UILoaderAlt;
      
      private var _flakeVisible:Boolean;
      
      private var _gearVisible:Boolean;
      
      public function SettingsIcons()
      {
         super();
      }
      
      public function get flakeVisible() : Boolean
      {
         return this._flakeVisible;
      }
      
      public function set flakeVisible(param1:Boolean) : void
      {
         this._flakeVisible = param1;
         invalidateData();
      }
      
      public function get gearVisible() : Boolean
      {
         return this._gearVisible;
      }
      
      public function set gearVisible(param1:Boolean) : void
      {
         this._gearVisible = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.flake.visible = false;
         this.gear.visible = false;
         this.flake.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.flake.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.gear.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.gear.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.flake.visible = this.flakeVisible;
            this.gear.visible = this.gearVisible;
         }
      }
      
      override protected function onDispose() : void
      {
         this.flake.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.flake.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.gear.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.gear.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         super.onDispose();
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(param1.currentTarget == this.flake ? TOOLTIPS.SETTINGSICON_FREEZED : TOOLTIPS.SETTINGSICON_CONDITIONS);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
