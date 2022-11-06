package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SkillsFade extends UIComponentEx
   {
      
      private static const GAP:int = 5;
       
      
      public var alertIcon:AlertIco;
      
      public var alertTF:TextField;
      
      public function SkillsFade()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.alertTF.text = VEH_COMPARE.VEHCONF_SKILLS_FADETEXT;
         App.utils.commons.updateTextFieldSize(this.alertTF);
         var _loc1_:int = this.alertTF.textWidth + this.alertIcon.width + GAP;
         this.alertIcon.x = width - _loc1_ >> 1;
         this.alertTF.x = this.alertIcon.x + this.alertIcon.width + GAP;
         this.alertIcon.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.alertTF = null;
         super.onDispose();
      }
   }
}
